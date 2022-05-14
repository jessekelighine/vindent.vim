" autoload/vindent.vim

"### Basic Helper Functions ###################################################

" Returns the indentation of a given line.
function! <SID>Get(line=line('.'))
	let l:return = matchstr(getline(a:line),'^\s*')
	if !exists('g:vindent_tabstop') | return l:return | endif
	return substitute(l:return,'\t',repeat(" ",g:vindent_tabstop),'g')
endfunction

" Returns 1 if "a:line" is a valid line number.
function! <SID>Valid(line)
	return a:line>=1 && a:line<=line('$')
endfunction

" Test if line is empty if "a:skip" is 1; otherwise return 0.
function! <SID>Skip(skip=1, line=line('.'))
	return a:skip ? empty(getline(a:line)) : 0
endfunction

"### Indent Comparisons #######################################################

function! <SID>Same(indent,line)
	return empty(getline(a:line)) ? 0 : <SID>Get(a:line)==a:indent
endfunction

function! <SID>NoLess(indent,line)
	return empty(getline(a:line)) ? 0 : matchstr(<SID>Get(a:line),"^".a:indent)==a:indent
endfunction

function! <SID>Less(indent,line)
	return !<SID>NoLess(a:indent,a:line)
endfunction

function! <SID>More(indent,line)
	return <SID>NoLess(a:indent,a:line) && !<SID>Same(a:indent,a:line)
endfunction

function! <SID>Diff(indent,line)
	return !<SID>Same(a:indent,a:line)
endfunction

"### Helper Functions #########################################################

" Find "prev" or "next" line with "a:type" indent, return line number.
function! <SID>Find(direct, type, line=line('.'), indent=<SID>Get(), skip=1)
	let l:line = a:line
	let l:inc  = a:direct=='prev' ? -1 : 1
	let l:type = "<SID>".a:type
	while 1
		let l:line = l:line + l:inc
		if !<SID>Valid(l:line)               | return 0      | endif
		if <SID>Skip(a:skip,l:line)          | continue      | endif
		if function(l:type)(a:indent,l:line) | return l:line | endif
	endwhile
endfunction

" Find the range (lines) of text with same indent level.
function! <SID>Range(stop_func, line=line('.'), skip=1)
	let l:indent = <SID>Get(a:line)
	" if l:indent=='' && a:stop_func!="Diff" | return [0,0] | endif
	let l:line_s = <SID>Find('prev', a:stop_func, a:line, l:indent, a:skip)
	let l:line_e = <SID>Find('next', a:stop_func, a:line, l:indent, a:skip)
	return [
				\ l:line_s==0 ? 1         : l:line_s+1,
				\ l:line_e==0 ? line('$') : l:line_e-1
				\ ]
endfunction

" Exclude empty lines on either ends from "a:range".
function! <SID>NoHang(range, beginend=[1,1])
	let l:range = a:range " | if l:range==[0,0] | return l:range | endif
	while a:beginend[0] && <SID>Skip(1,l:range[0]) | let l:range[0]=l:range[0]+1 | endwhile
	while a:beginend[1] && <SID>Skip(1,l:range[1]) | let l:range[1]=l:range[1]-1 | endwhile
	return l:range
endfunction

" Actually move the cursor according to inputs. (motion)
function! <SID>DoMotion(direct, mode, diff)
	let l:move = a:diff . ( a:direct=='prev' ? 'k' : 'j')
	if     a:mode=='N' | exe a:diff==0 ? "return"   : "norm! "    .l:move."_"
	elseif a:mode=='X' | exe a:diff==0 ? "norm! gv" : "norm! \egv".l:move."_"
	elseif a:mode=='O' | exe a:diff==0 ? "return"   : "norm! V"   .l:move."_"
	endif
endfunction

" Actually mov ethe cursor according to inputs. (text object)
function! <SID>DoObject(range)
	let  l:diff = a:range[1] - a:range[0]
	call cursor(a:range[0],0)
	exec l:diff==0 ? "norm! V" : "norm! V".l:diff."j"
endfunction

"### Main Functions ###########################################################

" Vindent Motion: Go to the "prev" or "next" line with the same indentation.
function! vindent#Motion(direct, count, mode, type, skip=1)
	" if <SID>Skip() | return | endif
	let [ l:line, l:to ] = [ line('.'), line('.') ]
	for l:time in range(a:count) " recursive
		let l:temp = <SID>Find(a:direct, a:type, l:to, <SID>Get(l:to), a:skip)
		if l:temp==0 | break | else | let l:to = l:temp | endif
	endfor
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:to))
endfunction

" Vindent Block Motion: Move to the next block with same indentation.
function! vindent#BlockMotion(direct, skip, stop_func, mode, count)
	let [ l:line, l:to ] = [ line('.'), line('.') ]
	for l:time in range(a:count) " recursive
		let l:range = <SID>NoHang(<SID>Range(a:stop_func,l:to,a:skip))
		let l:edge  = l:range[( a:direct=='prev' ? 0 : 1 )]
		let l:temp  = <SID>Find(a:direct,"Same",l:edge,<SID>Get(l:to),a:skip)
		if l:temp==0 | break | else | let l:to = l:temp | endif
	endfor
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:to))
endfunction

" Vindent Block Motion Edge: Move to the edge of same indentation block.
function! vindent#BlockEdgeMotion(direct, skip, stop_func, mode)
	let l:line  = line('.')
	let l:range = <SID>NoHang(<SID>Range(a:stop_func,l:line,a:skip))
	let l:edge  = l:range[( a:direct=='prev' ? 0 : 1 )] | if l:edge==0 | return | endif
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:edge))
endfunction

" Vindent Text Object: Select indent text objects.
function! vindent#Object(code, skip, stop_func, count)
	let l:range = <SID>NoHang(<SID>Range(a:stop_func,line("."),a:skip))
	let Find    = { direct,num,skip -> { x -> <SID>Skip(1,x) ? num : x }(<SID>Find(direct,"Less",num,<SID>Get(num),skip)) }
	for l:time in range(a:count-1) " recursive
		let [ l:zs, l:ze ] = [ Find("prev",l:range[0],a:skip), Find("next",l:range[1],a:skip) ]
		if     [ l:zs, l:ze ]==l:range | break " determine which line is new line
		elseif l:zs==l:range[0] | let l:new = l:ze
		elseif l:ze==l:range[1] | let l:new = l:zs
		else | let l:new = <SID>Less(<SID>Get(l:zs),l:ze) ? l:zs : l:ze | endif
		let l:range = <SID>Range("Less", l:new, a:skip)-><SID>NoHang() " find new range
	endfor
	if l:range==[1,line('$')] | return | endif " hard stop
	if a:code[0]==#'a' | let l:range[0] = { x -> x==0 ? 1         : x }( Find("prev",l:range[0],1) ) | endif
	if a:code[1]==#'I' | let l:range[1] = { x -> x==0 ? line('$') : x }( Find("next",l:range[1],1) ) | endif
	call <SID>DoObject(<SID>NoHang(l:range))
endfunction
