" plugin/indent.vim

if exists("g:loaded_vindent") | finish | endif | let s:save_cpo=&cpo | set cpo&vim

" Toggle vindent motion error behaviour.
if !exists("g:vindent_noisy") | let g:vindent_noisy = 0 | endif
command -nargs=0 -bang VindentNoisy :call <SID>VindentNoisy(<bang>1)
function! <SID>VindentNoisy(change)
	if a:change | let g:vindent_noisy = !g:vindent_noisy | endif
	echom " Vindent is now " . ( g:vindent_noisy ? "NOISY" : "SILENT" ) . "."
endfunction

nnoremap <Plug>(VindentMotion_next_diff) :<C-U>call                                        vindent#Motion('next',v:count1,'N',"Diff")<CR>
nnoremap <Plug>(VindentMotion_next_less) :<C-U>call                                        vindent#Motion('next',v:count1,'N',"Less")<CR>
nnoremap <Plug>(VindentMotion_next_more) :<C-U>call                                        vindent#Motion('next',v:count1,'N',"More")<CR>
nnoremap <Plug>(VindentMotion_next_same) :<C-U>call                                        vindent#Motion('next',v:count1,'N',"Same")<CR>
nnoremap <Plug>(VindentMotion_prev_diff) :<C-U>call                                        vindent#Motion('prev',v:count1,'N',"Diff")<CR>
nnoremap <Plug>(VindentMotion_prev_less) :<C-U>call                                        vindent#Motion('prev',v:count1,'N',"Less")<CR>
nnoremap <Plug>(VindentMotion_prev_more) :<C-U>call                                        vindent#Motion('prev',v:count1,'N',"More")<CR>
nnoremap <Plug>(VindentMotion_prev_same) :<C-U>call                                        vindent#Motion('prev',v:count1,'N',"Same")<CR>
onoremap <Plug>(VindentMotion_next_diff) :<C-U>call                                        vindent#Motion('next',v:count1,'O',"Diff")<CR>
onoremap <Plug>(VindentMotion_next_less) :<C-U>call                                        vindent#Motion('next',v:count1,'O',"Less")<CR>
onoremap <Plug>(VindentMotion_next_more) :<C-U>call                                        vindent#Motion('next',v:count1,'O',"More")<CR>
onoremap <Plug>(VindentMotion_next_same) :<C-U>call                                        vindent#Motion('next',v:count1,'O',"Same")<CR>
onoremap <Plug>(VindentMotion_prev_diff) :<C-U>call                                        vindent#Motion('prev',v:count1,'O',"Diff")<CR>
onoremap <Plug>(VindentMotion_prev_less) :<C-U>call                                        vindent#Motion('prev',v:count1,'O',"Less")<CR>
onoremap <Plug>(VindentMotion_prev_more) :<C-U>call                                        vindent#Motion('prev',v:count1,'O',"More")<CR>
onoremap <Plug>(VindentMotion_prev_same) :<C-U>call                                        vindent#Motion('prev',v:count1,'O',"Same")<CR>
xnoremap <Plug>(VindentMotion_next_diff) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Diff")<CR>
xnoremap <Plug>(VindentMotion_next_less) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Less")<CR>
xnoremap <Plug>(VindentMotion_next_more) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('next',g:vindent_temp,'X',"More")<CR>
xnoremap <Plug>(VindentMotion_next_same) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Same")<CR>
xnoremap <Plug>(VindentMotion_prev_diff) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Diff")<CR>
xnoremap <Plug>(VindentMotion_prev_less) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Less")<CR>
xnoremap <Plug>(VindentMotion_prev_more) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"More")<CR>
xnoremap <Plug>(VindentMotion_prev_same) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Same")<CR>

if exists("g:vindent_motion_same_prev") | exe 'map <silent> '.g:vindent_motion_same_prev.' <Plug>(VindentMotion_prev_same)' | endif
if exists("g:vindent_motion_same_next") | exe 'map <silent> '.g:vindent_motion_same_next.' <Plug>(VindentMotion_next_same)' | endif
if exists("g:vindent_motion_less_prev") | exe 'map <silent> '.g:vindent_motion_less_prev.' <Plug>(VindentMotion_prev_less)' | endif
if exists("g:vindent_motion_less_next") | exe 'map <silent> '.g:vindent_motion_less_next.' <Plug>(VindentMotion_next_less)' | endif
if exists("g:vindent_motion_more_prev") | exe 'map <silent> '.g:vindent_motion_more_prev.' <Plug>(VindentMotion_prev_more)' | endif
if exists("g:vindent_motion_more_next") | exe 'map <silent> '.g:vindent_motion_more_next.' <Plug>(VindentMotion_next_more)' | endif
if exists("g:vindent_motion_diff_prev") | exe 'map <silent> '.g:vindent_motion_diff_prev.' <Plug>(VindentMotion_prev_diff)' | endif
if exists("g:vindent_motion_diff_next") | exe 'map <silent> '.g:vindent_motion_diff_next.' <Plug>(VindentMotion_next_diff)' | endif

nnoremap <Plug>(VindentBlockMotion_OO_next) :<C-U>call                                        vindent#BlockMotion("next",0,"Diff","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_OO_prev) :<C-U>call                                        vindent#BlockMotion("prev",0,"Diff","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_OX_next) :<C-U>call                                        vindent#BlockMotion("next",0,"Less","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_OX_prev) :<C-U>call                                        vindent#BlockMotion("prev",0,"Less","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_XO_next) :<C-U>call                                        vindent#BlockMotion("next",1,"Diff","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_XO_prev) :<C-U>call                                        vindent#BlockMotion("prev",1,"Diff","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_XX_next) :<C-U>call                                        vindent#BlockMotion("next",1,"Less","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_XX_prev) :<C-U>call                                        vindent#BlockMotion("prev",1,"Less","N",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_OO_next) :<C-U>call                                        vindent#BlockMotion("next",0,"Diff","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_OO_prev) :<C-U>call                                        vindent#BlockMotion("prev",0,"Diff","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_OX_next) :<C-U>call                                        vindent#BlockMotion("next",0,"Less","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_OX_prev) :<C-U>call                                        vindent#BlockMotion("prev",0,"Less","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_XO_next) :<C-U>call                                        vindent#BlockMotion("next",1,"Diff","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_XO_prev) :<C-U>call                                        vindent#BlockMotion("prev",1,"Diff","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_XX_next) :<C-U>call                                        vindent#BlockMotion("next",1,"Less","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_XX_prev) :<C-U>call                                        vindent#BlockMotion("prev",1,"Less","O",v:count1)<CR>
xnoremap <Plug>(VindentBlockMotion_OO_next) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("next",0,"Diff","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_OO_prev) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("prev",0,"Diff","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_OX_next) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("next",0,"Less","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_OX_prev) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("prev",0,"Less","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_XO_next) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("next",1,"Diff","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_XO_prev) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("prev",1,"Diff","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_XX_next) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("next",1,"Less","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_XX_prev) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#BlockMotion("prev",1,"Less","X",g:vindent_temp)<CR>

if exists("g:vindent_motion_XO_prev") | exe 'map <silent> '.g:vindent_motion_XO_prev.' <Plug>(VindentBlockMotion_XO_prev)' | endif
if exists("g:vindent_motion_XO_next") | exe 'map <silent> '.g:vindent_motion_XO_next.' <Plug>(VindentBlockMotion_XO_next)' | endif
if exists("g:vindent_motion_OO_prev") | exe 'map <silent> '.g:vindent_motion_OO_prev.' <Plug>(VindentBlockMotion_OO_prev)' | endif
if exists("g:vindent_motion_OO_next") | exe 'map <silent> '.g:vindent_motion_OO_next.' <Plug>(VindentBlockMotion_OO_next)' | endif
if exists("g:vindent_motion_XX_prev") | exe 'map <silent> '.g:vindent_motion_XX_prev.' <Plug>(VindentBlockMotion_XX_prev)' | endif
if exists("g:vindent_motion_XX_next") | exe 'map <silent> '.g:vindent_motion_XX_next.' <Plug>(VindentBlockMotion_XX_next)' | endif
if exists("g:vindent_motion_OX_prev") | exe 'map <silent> '.g:vindent_motion_OX_prev.' <Plug>(VindentBlockMotion_OX_prev)' | endif
if exists("g:vindent_motion_OX_next") | exe 'map <silent> '.g:vindent_motion_OX_next.' <Plug>(VindentBlockMotion_OX_next)' | endif

nnoremap <Plug>(VindentBlockMotion_OO_se)      :call vindent#BlockEdgeMotion("next",0,"Diff","N")<CR>
nnoremap <Plug>(VindentBlockMotion_OO_ss)      :call vindent#BlockEdgeMotion("prev",0,"Diff","N")<CR>
nnoremap <Plug>(VindentBlockMotion_OX_se)      :call vindent#BlockEdgeMotion("next",0,"Less","N")<CR>
nnoremap <Plug>(VindentBlockMotion_OX_ss)      :call vindent#BlockEdgeMotion("prev",0,"Less","N")<CR>
nnoremap <Plug>(VindentBlockMotion_XO_se)      :call vindent#BlockEdgeMotion("next",1,"Diff","N")<CR>
nnoremap <Plug>(VindentBlockMotion_XO_ss)      :call vindent#BlockEdgeMotion("prev",1,"Diff","N")<CR>
nnoremap <Plug>(VindentBlockMotion_XX_se)      :call vindent#BlockEdgeMotion("next",1,"Less","N")<CR>
nnoremap <Plug>(VindentBlockMotion_XX_ss)      :call vindent#BlockEdgeMotion("prev",1,"Less","N")<CR>
onoremap <Plug>(VindentBlockMotion_OO_se)      :call vindent#BlockEdgeMotion("next",0,"Diff","O")<CR>
onoremap <Plug>(VindentBlockMotion_OO_ss)      :call vindent#BlockEdgeMotion("prev",0,"Diff","O")<CR>
onoremap <Plug>(VindentBlockMotion_OX_se)      :call vindent#BlockEdgeMotion("next",0,"Less","O")<CR>
onoremap <Plug>(VindentBlockMotion_OX_ss)      :call vindent#BlockEdgeMotion("prev",0,"Less","O")<CR>
onoremap <Plug>(VindentBlockMotion_XO_se)      :call vindent#BlockEdgeMotion("next",1,"Diff","O")<CR>
onoremap <Plug>(VindentBlockMotion_XO_ss)      :call vindent#BlockEdgeMotion("prev",1,"Diff","O")<CR>
onoremap <Plug>(VindentBlockMotion_XX_se)      :call vindent#BlockEdgeMotion("next",1,"Less","O")<CR>
onoremap <Plug>(VindentBlockMotion_XX_ss)      :call vindent#BlockEdgeMotion("prev",1,"Less","O")<CR>
xnoremap <Plug>(VindentBlockMotion_OO_se) <Esc>:call vindent#BlockEdgeMotion("next",0,"Diff","X")<CR>
xnoremap <Plug>(VindentBlockMotion_OO_ss) <Esc>:call vindent#BlockEdgeMotion("prev",0,"Diff","X")<CR>
xnoremap <Plug>(VindentBlockMotion_OX_se) <Esc>:call vindent#BlockEdgeMotion("next",0,"Less","X")<CR>
xnoremap <Plug>(VindentBlockMotion_OX_ss) <Esc>:call vindent#BlockEdgeMotion("prev",0,"Less","X")<CR>
xnoremap <Plug>(VindentBlockMotion_XO_se) <Esc>:call vindent#BlockEdgeMotion("next",1,"Diff","X")<CR>
xnoremap <Plug>(VindentBlockMotion_XO_ss) <Esc>:call vindent#BlockEdgeMotion("prev",1,"Diff","X")<CR>
xnoremap <Plug>(VindentBlockMotion_XX_se) <Esc>:call vindent#BlockEdgeMotion("next",1,"Less","X")<CR>
xnoremap <Plug>(VindentBlockMotion_XX_ss) <Esc>:call vindent#BlockEdgeMotion("prev",1,"Less","X")<CR>

if exists("g:vindent_motion_OO_ss") | exe 'map <silent> '.g:vindent_motion_OO_ss.' <Plug>(VindentBlockMotion_OO_ss)' | endif
if exists("g:vindent_motion_OO_se") | exe 'map <silent> '.g:vindent_motion_OO_se.' <Plug>(VindentBlockMotion_OO_se)' | endif
if exists("g:vindent_motion_OX_ss") | exe 'map <silent> '.g:vindent_motion_OX_ss.' <Plug>(VindentBlockMotion_OX_ss)' | endif
if exists("g:vindent_motion_OX_se") | exe 'map <silent> '.g:vindent_motion_OX_se.' <Plug>(VindentBlockMotion_OX_se)' | endif
if exists("g:vindent_motion_XO_ss") | exe 'map <silent> '.g:vindent_motion_XO_ss.' <Plug>(VindentBlockMotion_XO_ss)' | endif
if exists("g:vindent_motion_XO_se") | exe 'map <silent> '.g:vindent_motion_XO_se.' <Plug>(VindentBlockMotion_XO_se)' | endif
if exists("g:vindent_motion_XX_ss") | exe 'map <silent> '.g:vindent_motion_XX_ss.' <Plug>(VindentBlockMotion_XX_ss)' | endif
if exists("g:vindent_motion_XX_se") | exe 'map <silent> '.g:vindent_motion_XX_se.' <Plug>(VindentBlockMotion_XX_se)' | endif

onoremap <Plug>(VindentObject_OO_ii) :<C-U>call                                        vindent#Object('ii',0,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_OX_ii) :<C-U>call                                        vindent#Object('ii',0,"Less",v:count1)<CR>
onoremap <Plug>(VindentObject_XO_ii) :<C-U>call                                        vindent#Object('ii',1,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_XX_ii) :<C-U>call                                        vindent#Object('ii',1,"Less",v:count1)<CR>
onoremap <Plug>(VindentObject_OO_ai) :<C-U>call                                        vindent#Object('ai',0,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_OX_ai) :<C-U>call                                        vindent#Object('ai',0,"Less",v:count1)<CR>
onoremap <Plug>(VindentObject_XO_ai) :<C-U>call                                        vindent#Object('ai',1,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_XX_ai) :<C-U>call                                        vindent#Object('ai',1,"Less",v:count1)<CR>
onoremap <Plug>(VindentObject_OO_aI) :<C-U>call                                        vindent#Object('aI',0,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_OX_aI) :<C-U>call                                        vindent#Object('aI',0,"Less",v:count1)<CR>
onoremap <Plug>(VindentObject_XO_aI) :<C-U>call                                        vindent#Object('aI',1,"Diff",v:count1)<CR>
onoremap <Plug>(VindentObject_XX_aI) :<C-U>call                                        vindent#Object('aI',1,"Less",v:count1)<CR>
xnoremap <Plug>(VindentObject_OO_ii) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ii',0,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_OX_ii) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ii',0,"Less",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XO_ii) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ii',1,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XX_ii) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ii',1,"Less",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_OO_ai) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ai',0,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_OX_ai) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ai',0,"Less",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XO_ai) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ai',1,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XX_ai) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('ai',1,"Less",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_OO_aI) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('aI',0,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_OX_aI) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('aI',0,"Less",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XO_aI) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('aI',1,"Diff",g:vindent_temp)<CR>
xnoremap <Plug>(VindentObject_XX_aI) :<C-U>let g:vindent_temp=v:count1<CR>gv<Esc>:call vindent#Object('aI',1,"Less",g:vindent_temp)<CR>

if exists("g:vindent_object_OO_ii") | exe 'xmap <silent> '.g:vindent_object_OO_ii.' <Plug>(VindentObject_OO_ii)' | exe 'omap <silent> '.g:vindent_object_OO_ii.' <Plug>(VindentObject_OO_ii)' | endif
if exists("g:vindent_object_OX_ii") | exe 'xmap <silent> '.g:vindent_object_OX_ii.' <Plug>(VindentObject_OX_ii)' | exe 'omap <silent> '.g:vindent_object_OX_ii.' <Plug>(VindentObject_OX_ii)' | endif
if exists("g:vindent_object_XO_ii") | exe 'xmap <silent> '.g:vindent_object_XO_ii.' <Plug>(VindentObject_XO_ii)' | exe 'omap <silent> '.g:vindent_object_XO_ii.' <Plug>(VindentObject_XO_ii)' | endif
if exists("g:vindent_object_XX_ii") | exe 'xmap <silent> '.g:vindent_object_XX_ii.' <Plug>(VindentObject_XX_ii)' | exe 'omap <silent> '.g:vindent_object_XX_ii.' <Plug>(VindentObject_XX_ii)' | endif
if exists("g:vindent_object_OO_ai") | exe 'xmap <silent> '.g:vindent_object_OO_ai.' <Plug>(VindentObject_OO_ai)' | exe 'omap <silent> '.g:vindent_object_OO_ai.' <Plug>(VindentObject_OO_ai)' | endif
if exists("g:vindent_object_OX_ai") | exe 'xmap <silent> '.g:vindent_object_OX_ai.' <Plug>(VindentObject_OX_ai)' | exe 'omap <silent> '.g:vindent_object_OX_ai.' <Plug>(VindentObject_OX_ai)' | endif
if exists("g:vindent_object_XO_ai") | exe 'xmap <silent> '.g:vindent_object_XO_ai.' <Plug>(VindentObject_XO_ai)' | exe 'omap <silent> '.g:vindent_object_XO_ai.' <Plug>(VindentObject_XO_ai)' | endif
if exists("g:vindent_object_XX_ai") | exe 'xmap <silent> '.g:vindent_object_XX_ai.' <Plug>(VindentObject_XX_ai)' | exe 'omap <silent> '.g:vindent_object_XX_ai.' <Plug>(VindentObject_XX_ai)' | endif
if exists("g:vindent_object_OO_aI") | exe 'xmap <silent> '.g:vindent_object_OO_aI.' <Plug>(VindentObject_OO_aI)' | exe 'omap <silent> '.g:vindent_object_OO_aI.' <Plug>(VindentObject_OO_aI)' | endif
if exists("g:vindent_object_OX_aI") | exe 'xmap <silent> '.g:vindent_object_OX_aI.' <Plug>(VindentObject_OX_aI)' | exe 'omap <silent> '.g:vindent_object_OX_aI.' <Plug>(VindentObject_OX_aI)' | endif
if exists("g:vindent_object_XO_aI") | exe 'xmap <silent> '.g:vindent_object_XO_aI.' <Plug>(VindentObject_XO_aI)' | exe 'omap <silent> '.g:vindent_object_XO_aI.' <Plug>(VindentObject_XO_aI)' | endif
if exists("g:vindent_object_XX_aI") | exe 'xmap <silent> '.g:vindent_object_XX_aI.' <Plug>(VindentObject_XX_aI)' | exe 'omap <silent> '.g:vindent_object_XX_aI.' <Plug>(VindentObject_XX_aI)' | endif

let &cpo = s:save_cpo | unlet s:save_cpo | let g:loaded_vindent=1
