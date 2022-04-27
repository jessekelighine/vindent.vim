" autoload/vindent.vim

" Returns the indentation of a given line.
function! vindent#Get(line=line('.'))
	return matchstr(getline(a:line),'^\s*')
endfunction

" Returns 1 if the indentation on line `a:line` is identical to `a:indent`.
function! vindent#Same(indent,line)
	return vindent#Get(a:line)==a:indent ? 1 : 0
endfunction

" Returns 1 if the indentation on line `a:line` is no less than `a:indent`.
function! vindent#NoLess(indent,line)
	return matchstr(vindent#Get(a:line),"^".a:indent)!="" ? 1 : 0
endfunction

"### Motion ###################################################################

" Find the "prev" or "next" line with the same indentation and return its line
" number.  If no such lines are found, then 0 is returned.
function! vindent#Find(direct, line=line('.'), skip=1)
	let l:line   = a:line
	let l:indent = vindent#Get(a:line)
	let l:inc    = a:direct=='prev' ? -1 : 1
	while 1
		let l:line = l:line + l:inc
		if a:skip && getline(l:line)==''  | continue      | endif
		if vindent#Same(l:indent,l:line)  | return l:line | endif
		if l:line<=1 || l:line>=line('$') | return 0      | endif
	endwhile
endfunction

" Go to the "prev" or "next" line with the same indentation.
function! vindent#Move(direct, mode)
	if getline('.')=="" | return | endif " return if on empty line.
	let l:moveto = vindent#Find(a:direct) | if l:moveto==0 | return | endif " special case
	let l:move   = abs(l:moveto-line('.')) . ( a:direct=='prev' ? 'k' : 'j' )
	if a:mode=='N' | silent exec 'norm :'.l:moveto."\<CR>_" | endif
	if a:mode=='X' | silent exec "norm \<Esc>gv".l:move.'_' | endif
	if a:mode=='O' | silent exec "norm V".l:move."_"        | endif
endfunction

"### Text Object ##############################################################

" Find the range (lines) of text with same indent level.  If the line with
" line number `a:line` is not indented, then [0,0] is returned.  If `skip`
" is set, then empty lines would be ignored.  If `hanging` is set to 0, then
" empty lines selected at the beginning or end would not be in the returned
" range.
function! vindent#Range(line=line('.'), skip=1, hanging=0)
	let l:indent = vindent#Get(a:line) | if l:indent=='' | return [0,0] | endif
	let [ l:line_s, l:line_e ] = [ a:line, a:line ]
	while l:line_s<=line('$') && ( vindent#NoLess(l:indent,l:line_s) || (a:skip?getline(l:line_s)=="":0) ) | let l:line_s=l:line_s-1 | endwhile
	while l:line_e<=line('$') && ( vindent#NoLess(l:indent,l:line_e) || (a:skip?getline(l:line_e)=="":0) ) | let l:line_e=l:line_e+1 | endwhile
	let l:return = [ l:line_s+1, l:line_e-1 ]
	if !a:hanging
		while 1 | if getline(l:return[0])=="" | let l:return[0] = l:return[0]+1 | else | break | endif | endwhile
		while 1 | if getline(l:return[1])=="" | let l:return[1] = l:return[1]-1 | else | break | endif | endwhile
	endif
	return l:return
endfunction

" Define indent text objects.
function! vindent#Object(code)
	let l:range = vindent#Range() | if l:range==[0,0] | return | endif " return if there is no indent.
	if  l:range[0]==l:range[1]    | exec "norm V"     | return | endif " spcial case
	call cursor(l:range[0],0)
	if     a:code==#'i' | exec "norm  V" . (l:range[1]-l:range[0]  ) . 'j'
	elseif a:code==#'a' | exec "norm kV" . (l:range[1]-l:range[0]+1) . 'j'
	elseif a:code==#'I' | exec "norm kV" . (l:range[1]-l:range[0]+2) . 'j'
	endif
endfunction
