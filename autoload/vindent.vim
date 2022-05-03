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

" Test if line is empty if `a:skip==1`; otherwise return 0.
function! <SID>Skip(skip=1, line=line('.'))
	return a:skip ? empty(getline(a:line)) : 0
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
function! <SID>Find(direct, line=line('.'), indent=<SID>Get(line('.')), skip=1)
	let l:line = a:line
	let l:inc  = a:direct=='prev' ? -1 : 1
	while 1
		let l:line = l:line + l:inc
		if !<SID>Valid(l:line)        | return 0      | endif
		if <SID>Skip(a:skip,l:line)   | continue      | endif
		if <SID>Same(a:indent,l:line) | return l:line | endif
	endwhile
endfunction

" Go to the "prev" or "next" line with the same indentation.
function! vindent#Move(direct, mode)
	if <SID>Skip() | return | endif
	let l:moveto = <SID>Find(a:direct)
	if l:moveto==0
		if a:mode=='X' | silent exec "norm gv" | endif
		return
	endif
	let l:move   = abs(l:moveto-line('.')) . ( a:direct=='prev' ? 'k' : 'j' )
	if     a:mode=='N' | silent exec "norm :"  . l:moveto . "\<CR>_"
	elseif a:mode=='X' | silent exec "norm gv" . l:move   . "_"
	elseif a:mode=='O' | silent exec "norm  V" . l:move   . "_"
	endif
endfunction

"### Text Object ##############################################################

" Find the range (lines) of text with same indent level.  If the line with
" line number `a:line` is not indented, then [0,0] is returned.  If `skip`
" is set, then empty lines would be ignored.
function! <SID>Range(exact, line=line('.'), skip=1)
	let l:indent = <SID>Get(a:line) | if l:indent=='' | return [0,0] | endif
	let [ l:ls, l:le ] = [ a:line, a:line ]
	let l:test = a:exact ? "<SID>Same" : "<SID>NoLess"
	while <SID>Valid(l:ls) && ( function(l:test)(l:indent,l:ls) || <SID>Skip(a:skip,l:ls) ) | let l:ls=l:ls-1 | endwhile
	while <SID>Valid(l:le) && ( function(l:test)(l:indent,l:le) || <SID>Skip(a:skip,l:le) ) | let l:le=l:le+1 | endwhile
	return [ l:ls+1, l:le-1 ]
endfunction

" exclude empty lines on either ends from `a:range`.
function! <SID>NoHang(range, begin, end)
	let l:range = a:range
	while a:begin && <SID>Skip(1,l:range[0]) | let l:range[0]=l:range[0]+1 | endwhile
	while a:end   && <SID>Skip(1,l:range[1]) | let l:range[1]=l:range[1]-1 | endwhile
	return l:range
endfunction

" Define indent text objects.
let s:nohang = { 'ii': [1, 1], 'iI': [1, 1], 'ai': [0, 1], 'aI': [0, 0] }
let s:exact  = { 'ii': 0,      'iI': 1,      'ai': 0,      'aI': 0      }
let s:skip   = { 'ii': 1,      'iI': 0,      'ai': 1,      'aI': 1      }
function! vindent#Object(code)
	let l:range = <SID>Range(s:exact[a:code],line('.'),s:skip[a:code]) | if l:range==[0,0] | return | endif
	let l:range = <SID>NoHang(l:range, s:nohang[a:code][0], s:nohang[a:code][1])
	let l:move  = l:range[1] - l:range[0]
	call cursor(l:range[0],0)
	if     a:code==#'ii' | exec "norm  V" . ( l:move==0 ? '' : l:move.'j' )
	elseif a:code==#'iI' | exec "norm  V" . ( l:move==0 ? '' : l:move.'j' )
	elseif a:code==#'ai' | exec "norm kV" . ( l:move+1 ) . 'j'
	elseif a:code==#'aI' | exec "norm kV" . ( l:move+2 ) . 'j'
	endif
endfunction
