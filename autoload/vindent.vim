" autoload/vindent.vim

"### Utilities ################################################################

" Returns the indentation of a given line.
function! <SID>Get(line=line('.'))
	return matchstr(getline(a:line),'^\s*')
endfunction

" Returns 1 if `a:line` is a valid line number.
function! <SID>Valid(line=line('.'))
	return a:line>=1 && a:line<=line('$') ? 1 : 0
endfunction

"### Test Indent Levels #######################################################

" Returns 1 if the indentation on `a:line` is identical to `a:indent`.
function! <SID>Same(indent,line)
	return <SID>Get(a:line)==a:indent ? 1 : 0
endfunction

" Returns 1 if the indentation on `a:line` is no less than `a:indent`.
function! <SID>NoLess(indent,line)
	return matchstr(<SID>Get(a:line),"^".a:indent)!="" ? 1 : 0
endfunction

"### Motion ###################################################################

" Find the "prev" or "next" line with the same indentation and return its line
" number.  If no such lines are found, then 0 is returned.
function! <SID>Find(direct, line=line('.'), skip=1)
	let l:line   = a:line
	let l:indent = <SID>Get(a:line)
	let l:inc    = a:direct=='prev' ? -1 : 1
	while 1
		let l:line = l:line + l:inc
		if !<SID>Valid(l:line)           | return 0      | endif
		if a:skip && getline(l:line)=='' | continue      | endif
		if <SID>Same(l:indent,l:line)    | return l:line | endif
	endwhile
endfunction

" Go to the "prev" or "next" line with the same indentation.
function! vindent#Move(direct, mode)
	if getline('.')=="" | return | endif " return if on empty line.
	let l:moveto = <SID>Find(a:direct)
	if l:moveto==0 " special case if `<SID>Find` returns 0.
		if a:mode=='X' | silent exec "norm gv" | endif
		return
	endif
	let l:move   = abs(l:moveto-line('.')) . ( a:direct=='prev' ? 'k' : 'j' )
	if a:mode=='N' | silent exec "norm :".l:moveto."\<CR>_" | endif
	if a:mode=='X' | silent exec "norm gv".l:move."_"       | endif
	if a:mode=='O' | silent exec "norm V".l:move."_"        | endif
endfunction

"### Text Object ##############################################################

" Find the range (lines) of text with same indent level.  If the line with
" line number `a:line` is not indented, then [0,0] is returned.  If `skip`
" is set, then empty lines would be ignored.  If `hanging` is set to 0, then
" empty lines selected at the beginning or end would not be in the returned
" range.
function! <SID>Range(line=line('.'), skip=1)
	let l:indent = <SID>Get(a:line) | if l:indent=='' | return [0,0] | endif " return [0,0] if there is no indent
	let [ l:ls, l:le ] = [ a:line, a:line ]
	while <SID>Valid(l:ls) && ( <SID>NoLess(l:indent,l:ls) || (a:skip?getline(l:ls)=="":0) ) | let l:ls=l:ls-1 | endwhile
	while <SID>Valid(l:le) && ( <SID>NoLess(l:indent,l:le) || (a:skip?getline(l:le)=="":0) ) | let l:le=l:le+1 | endwhile
	return [ l:ls+1, l:le-1 ]
endfunction

" exclude empty lines on either ends from `a:range`.
function! <SID>NoHang(range, begin, end)
	let l:range = a:range
	while a:begin && getline(l:range[0])=="" | let l:range[0]=l:range[0]+1 | endwhile
	while a:end   && getline(l:range[1])=="" | let l:range[1]=l:range[1]-1 | endwhile
	return l:range
endfunction

" Define indent text objects.
function! vindent#Object(code)
	let l:range = <SID>Range() | if l:range==[0,0] | return | endif " return if there is no indent.
	let l:range = <SID>NoHang( l:range, (a:code[0]==#'i'?1:0), (a:code[1]==#'i'?1:0) )
	let l:move  = l:range[1] - l:range[0]
	call cursor(l:range[0],0)
	if a:code==#'ii' | exec "norm  V" . ( l:move==0 ? '' : l:move.'j' ) | endif
	if a:code==#'ai' | exec "norm kV" . ( l:move+1 ) . 'j'              | endif
	if a:code==#'aI' | exec "norm kV" . ( l:move+2 ) . 'j'              | endif
endfunction
