" autoload/vindent.vim

"### Basic Helper Functions ###################################################

" Returns the indentation of a given line.
function! <SID>Get(line=line('.'))
	let l:return = matchstr(getline(a:line),'^\s*')
	return exists('g:vindent_tabstop') ? substitute(l:return,'\t',repeat(" ",g:vindent_tabstop),'g') : l:return
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
" Test if indentation on "a:line" is "FUNCTION_NAME" than/as/to "a:indent".

function! <SID>Same(indent,line)
	return <SID>Get(a:line)==a:indent
endfunction

function! <SID>NoLess(indent,line)
	return matchstr(<SID>Get(a:line),"^".a:indent)==a:indent
endfunction

function! <SID>Less(indent,line)
	return !<SID>NoLess(a:indent,a:line)
endfunction

function! <SID>More(indent,line)
	return <SID>NoLess(a:indent,a:line) && !<SID>Same(a:indent,a:line)
endfunction

function! <SID>NoMore(indent,line)
	return !<SID>More(a:indent,a:line)
endfunction

function! <SID>Diff(indent,line)
	return !<SID>Same(a:indent,a:line)
endfunction

"### Motion ###################################################################

" Find the "prev" or "next" line with the same indentation and return its line number.
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

" Calls "<SID>Find" recursively "a:count" times.
function! <SID>RecursiveFind(direct, count, type, line=line('.'), indent=<SID>Get(), skip=1)
	let l:line = a:line
	for l:time in range(a:count)
		let l:line = <SID>Find(a:direct, a:type, l:line, <SID>Get(l:line), a:skip)
	endfor
	return l:line
endfunction

" Vindent Motion: Go to the "prev" or "next" line with the same indentation.
function! vindent#Motion(direct, mode, count, type)
	if <SID>Skip() | return | endif
	let l:moveto = <SID>RecursiveFind(a:direct, a:count, a:type)
	let l:move   = abs(l:moveto - line('.')) . ( a:direct=='prev' ? 'k' : 'j' )
	if     a:mode=='N' | silent exec l:moveto==0 ? "return"   : "norm! "    .l:move."_"
	elseif a:mode=='X' | silent exec l:moveto==0 ? "norm! gv" : "norm! \egv".l:move."_"
	elseif a:mode=='O' | silent exec l:moveto==0 ? "return"   : "norm! V"   .l:move."_"
	endif
endfunction

"### Text Object ##############################################################

" Find the range (lines) of text with same indent level.
function! <SID>Range(exact, line=line('.'), skip=1)
	let l:indent = <SID>Get(a:line) | if l:indent=='' | return [0,0] | endif
	let [ l:ls, l:le ] = [ a:line, a:line ]
	let l:test = a:exact ? "<SID>Same" : "<SID>NoLess"
	while <SID>Valid(l:ls) && ( function(l:test)(l:indent,l:ls) || <SID>Skip(a:skip,l:ls) ) | let l:ls=l:ls-1 | endwhile
	while <SID>Valid(l:le) && ( function(l:test)(l:indent,l:le) || <SID>Skip(a:skip,l:le) ) | let l:le=l:le+1 | endwhile
	return [ l:ls+1, l:le-1 ]
endfunction

" Exclude empty lines on either ends from "a:range".
function! <SID>NoHang(range, begin, end)
	let l:range = a:range
	while a:begin && <SID>Skip(1,l:range[0]) | let l:range[0]=l:range[0]+1 | endwhile
	while a:end   && <SID>Skip(1,l:range[1]) | let l:range[1]=l:range[1]-1 | endwhile
	return l:range
endfunction

" Vindent Text Object: Select indent text objects.
let s:nohang = { 'ii': [1, 1], 'iI': [1, 1], 'ai': [0, 1], 'aI': [0, 0] }
let s:exact  = { 'ii': 0,      'iI': 1,      'ai': 0,      'aI': 0      }
function! vindent#Object(code)
	let l:range = <SID>Range(s:exact[a:code]) | if l:range==[0,0] | return | endif
	let l:range = <SID>NoHang(l:range, s:nohang[a:code][0], s:nohang[a:code][1])
	let l:move  = l:range[1] - l:range[0]
	call cursor(l:range[0],0)
	if     a:code==#'ii' | exec "norm!  V" . ( l:move==0 ? '' : l:move.'j' )
	elseif a:code==#'iI' | exec "norm!  V" . ( l:move==0 ? '' : l:move.'j' )
	elseif a:code==#'ai' | exec "norm! kV" . ( l:move+1 ) . 'j'
	elseif a:code==#'aI' | exec "norm! kV" . ( l:move+2 ) . 'j'
	endif
endfunction
