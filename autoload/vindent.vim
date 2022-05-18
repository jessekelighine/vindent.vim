" autoload/vindent.vim

"### Helper Functions #########################################################

" Test if line is empty.
let s:empty = { line -> empty(getline(line)) }

" Compare indentation levels.
let s:compare = {
			\ "Same":   { indent,line -> s:empty(line) ? 0 : indent==indent(line) },
			\ "NoLess": { indent,line -> s:empty(line) ? 0 : indent<=indent(line) },
			\ "Less":   { indent,line -> !s:compare["NoLess"](indent,line) },
			\ "More":   { indent,line -> !s:compare["Same"](indent,line) && s:compare["NoLess"](indent,line) },
			\ "Diff":   { indent,line -> !s:compare["Same"](indent,line) },
			\ }

" Find "prev" or "next" line with "a:stop_func" indent, return line number.
function! <SID>Find(direct, stop_func, line, indent, skip)
	let l:line = a:line
	let l:inc  = a:direct=="prev" ? -1 : 1
	while 1
		let l:line += l:inc
		if l:line<1 || l:line>line("$")            | return 0      | endif
		if ( a:skip ? s:empty(l:line) : 0 )        | continue      | endif
		if s:compare[a:stop_func](a:indent,l:line) | return l:line | endif
	endwhile
endfunction

" Find the range (lines) of text with same indent level.
function! <SID>Range(stop_func, line, skip)
	let l:indent = indent(a:line)
	let l:line_s = { x -> x==0 ? 1         : x+1 }(<SID>Find("prev", a:stop_func, a:line, l:indent, a:skip))
	let l:line_e = { x -> x==0 ? line("$") : x-1 }(<SID>Find("next", a:stop_func, a:line, l:indent, a:skip))
	return [ l:line_s, l:line_e]
endfunction

" Exclude empty lines on either ends from "a:range".
function! <SID>NoHang(range)
	let l:range = a:range
	while s:empty(l:range[0]) | let l:range[0]=l:range[0]+1 | endwhile
	while s:empty(l:range[1]) | let l:range[1]=l:range[1]-1 | endwhile
	return l:range
endfunction

" Actually move the cursor according to inputs. (motion)
function! <SID>DoMotion(direct, mode, diff)
	let l:move = a:diff . ( a:direct=="prev" ? "k" : "j")
	if     a:mode=="N" | exe a:diff==0 ? "return"   : "norm! "    .l:move."_"
	elseif a:mode=="X" | exe a:diff==0 ? "norm! gv" : "norm! \egv".l:move."_"
	elseif a:mode=="O" | exe a:diff==0 ? "return"   : "norm! V"   .l:move."_"
	endif
endfunction

" Actually mov ethe cursor according to inputs. (text object)
function! <SID>DoObject(range)
	call cursor(a:range[0],0)
	exec { x -> "norm! V" . ( x==0 ? "" : x."j" ) }( a:range[1] - a:range[0] )
endfunction

"### Main Functions ###########################################################

" Vindent Motion: Go to the "prev" or "next" line with the same indentation.
function! vindent#Motion(direct, count, mode, stop_func, skip=1)
	let [ l:line, l:to ] = [ line("."), line(".") ]
	for l:time in range(a:count) " recursive
		let l:temp = <SID>Find(a:direct,a:stop_func,l:to,indent(l:to),a:skip)
		if l:temp==0 | break | else | let l:to = l:temp | endif
	endfor
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:to))
endfunction

" Vindent Block Motion: Move to the next block with same indentation.
function! vindent#BlockMotion(direct, skip, stop_func, mode, count)
	let [ l:line, l:to ] = [ line("."), line(".") ]
	for l:time in range(a:count) " recursive
		let l:edge = <SID>NoHang(<SID>Range(a:stop_func,l:to,a:skip))[( a:direct=="prev" ? 0 : 1 )]
		let l:temp = <SID>Find(a:direct,"Same",l:edge,indent(l:to),a:skip)
		if l:temp==0 | break | else | let l:to = l:temp | endif
	endfor
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:to))
endfunction

" Vindent Block Motion Edge: Move to the edge of same indentation block.
function! vindent#BlockEdgeMotion(direct, skip, stop_func, mode)
	let l:line = line(".")
	let l:edge = <SID>NoHang(<SID>Range(a:stop_func,l:line,a:skip))[( a:direct=="prev" ? 0 : 1 )]
	call <SID>DoMotion(a:direct, a:mode, abs(l:line-l:edge))
endfunction

" Vindent Text Object: Select indent text objects.
function! vindent#Object(code, skip, stop_func, count)
	let VindentF = { direct,ln,skip -> { x -> s:empty(x) ? ln : x }(<SID>Find(direct,"Less",ln,indent(ln),skip)) }
	let VindentR = { line -> <SID>Range(a:stop_func,line,a:skip) }
	let l:range  = VindentR(line("."))-><SID>NoHang()
	for l:time in range(a:count-1) " recursive
		let [ l:zs, l:ze ] = [ VindentF("prev",l:range[0],a:skip), VindentF("next",l:range[1],a:skip) ]
		let l:test = [ VindentR(l:range[0])[0], VindentR(l:range[1])[1] ]
		if l:zs+1!=l:test[0] | let l:zs = l:range[0] | endif
		if l:ze-1!=l:test[1] | let l:ze = l:range[1] | endif
		if l:zs!=l:range[0] && l:ze!=l:range[1] && s:compare["Diff"](indent(l:zs),l:ze)
			if s:compare["More"](indent(l:zs),l:ze) | let l:zs = l:range[0]
			else                                    | let l:ze = l:range[1]
			endif
		endif
		if [l:zs,l:ze]==l:range || [l:zs,l:ze]==[1,line("$")] | break | endif
		let l:range = [ VindentR(l:zs)[0], VindentR(l:ze)[1] ]-><SID>NoHang()
	endfor
	if a:code[0]==#"a" | let l:range[0] = { x -> x==0 ? 1         : x }( VindentF("prev",l:range[0],1) ) | endif
	if a:code[1]==#"I" | let l:range[1] = { x -> x==0 ? line("$") : x }( VindentF("next",l:range[1],1) ) | endif
	call <SID>DoObject(<SID>NoHang(l:range))
endfunction
