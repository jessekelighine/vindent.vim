" plugin/indent.vim

if exists("g:loaded_vindent") | finish | endif | let g:loaded_vindent=1

nnoremap <Plug>(VindentMotion_next_diff) :<C-U>call                                      vindent#Motion('next',v:count1,'N',"Diff")<CR>
nnoremap <Plug>(VindentMotion_next_less) :<C-U>call                                      vindent#Motion('next',v:count1,'N',"Less")<CR>
nnoremap <Plug>(VindentMotion_next_more) :<C-U>call                                      vindent#Motion('next',v:count1,'N',"More")<CR>
nnoremap <Plug>(VindentMotion_next_same) :<C-U>call                                      vindent#Motion('next',v:count1,'N',"Same")<CR>
nnoremap <Plug>(VindentMotion_prev_diff) :<C-U>call                                      vindent#Motion('prev',v:count1,'N',"Diff")<CR>
nnoremap <Plug>(VindentMotion_prev_less) :<C-U>call                                      vindent#Motion('prev',v:count1,'N',"Less")<CR>
nnoremap <Plug>(VindentMotion_prev_more) :<C-U>call                                      vindent#Motion('prev',v:count1,'N',"More")<CR>
nnoremap <Plug>(VindentMotion_prev_same) :<C-U>call                                      vindent#Motion('prev',v:count1,'N',"Same")<CR>
onoremap <Plug>(VindentMotion_next_diff) :<C-U>call                                      vindent#Motion('next',v:count1,'O',"Diff")<CR>
onoremap <Plug>(VindentMotion_next_less) :<C-U>call                                      vindent#Motion('next',v:count1,'O',"Less")<CR>
onoremap <Plug>(VindentMotion_next_more) :<C-U>call                                      vindent#Motion('next',v:count1,'O',"More")<CR>
onoremap <Plug>(VindentMotion_next_same) :<C-U>call                                      vindent#Motion('next',v:count1,'O',"Same")<CR>
onoremap <Plug>(VindentMotion_prev_diff) :<C-U>call                                      vindent#Motion('prev',v:count1,'O',"Diff")<CR>
onoremap <Plug>(VindentMotion_prev_less) :<C-U>call                                      vindent#Motion('prev',v:count1,'O',"Less")<CR>
onoremap <Plug>(VindentMotion_prev_more) :<C-U>call                                      vindent#Motion('prev',v:count1,'O',"More")<CR>
onoremap <Plug>(VindentMotion_prev_same) :<C-U>call                                      vindent#Motion('prev',v:count1,'O',"Same")<CR>
xnoremap <Plug>(VindentMotion_next_diff) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Diff")<CR>
xnoremap <Plug>(VindentMotion_next_less) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Less")<CR>
xnoremap <Plug>(VindentMotion_next_more) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('next',g:vindent_temp,'X',"More")<CR>
xnoremap <Plug>(VindentMotion_next_same) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('next',g:vindent_temp,'X',"Same")<CR>
xnoremap <Plug>(VindentMotion_prev_diff) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Diff")<CR>
xnoremap <Plug>(VindentMotion_prev_less) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Less")<CR>
xnoremap <Plug>(VindentMotion_prev_more) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"More")<CR>
xnoremap <Plug>(VindentMotion_prev_same) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#Motion('prev',g:vindent_temp,'X',"Same")<CR>

if exists("g:vindent_motion_same_prev") | exe 'noremap <silent> '.g:vindent_motion_same_prev.' <Plug>(VindentMotion_prev_same)' | endif
if exists("g:vindent_motion_same_next") | exe 'noremap <silent> '.g:vindent_motion_same_next.' <Plug>(VindentMotion_next_same)' | endif
if exists("g:vindent_motion_less_prev") | exe 'noremap <silent> '.g:vindent_motion_less_prev.' <Plug>(VindentMotion_prev_less)' | endif
if exists("g:vindent_motion_less_next") | exe 'noremap <silent> '.g:vindent_motion_less_next.' <Plug>(VindentMotion_next_less)' | endif
if exists("g:vindent_motion_more_prev") | exe 'noremap <silent> '.g:vindent_motion_more_prev.' <Plug>(VindentMotion_prev_more)' | endif
if exists("g:vindent_motion_more_next") | exe 'noremap <silent> '.g:vindent_motion_more_next.' <Plug>(VindentMotion_next_more)' | endif
if exists("g:vindent_motion_diff_prev") | exe 'noremap <silent> '.g:vindent_motion_diff_prev.' <Plug>(VindentMotion_prev_diff)' | endif
if exists("g:vindent_motion_diff_next") | exe 'noremap <silent> '.g:vindent_motion_diff_next.' <Plug>(VindentMotion_next_diff)' | endif

xnoremap <Plug>(VindentObject_ii) :call vindent#Object('ii')<CR>
xnoremap <Plug>(VindentObject_iI) :call vindent#Object('iI')<CR>
xnoremap <Plug>(VindentObject_ai) :call vindent#Object('ai')<CR>
xnoremap <Plug>(VindentObject_aI) :call vindent#Object('aI')<CR>
onoremap <Plug>(VindentObject_ii) :call vindent#Object('ii')<CR>
onoremap <Plug>(VindentObject_iI) :call vindent#Object('iI')<CR>
onoremap <Plug>(VindentObject_ai) :call vindent#Object('ai')<CR>
onoremap <Plug>(VindentObject_aI) :call vindent#Object('aI')<CR>

if exists("g:vindent_object_ii") | exe 'xnoremap <silent> '.g:vindent_object_ii.' <Plug>(VindentObject_ii)' | exe 'onoremap <silent> '.g:vindent_object_ii.' <Plug>(VindentObject_ii)' | endif
if exists("g:vindent_object_iI") | exe 'xnoremap <silent> '.g:vindent_object_iI.' <Plug>(VindentObject_iI)' | exe 'onoremap <silent> '.g:vindent_object_iI.' <Plug>(VindentObject_iI)' | endif
if exists("g:vindent_object_ai") | exe 'xnoremap <silent> '.g:vindent_object_ai.' <Plug>(VindentObject_ai)' | exe 'onoremap <silent> '.g:vindent_object_ai.' <Plug>(VindentObject_ai)' | endif
if exists("g:vindent_object_aI") | exe 'xnoremap <silent> '.g:vindent_object_aI.' <Plug>(VindentObject_aI)' | exe 'onoremap <silent> '.g:vindent_object_aI.' <Plug>(VindentObject_aI)' | endif

nnoremap <Plug>(VindentBlockMotion_prev) :<C-U>call                                      vindent#BlockMotion("prev",0,"Diff","N",v:count1)<CR>
nnoremap <Plug>(VindentBlockMotion_next) :<C-U>call                                      vindent#BlockMotion("next",0,"Diff","N",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_prev) :<C-U>call                                      vindent#BlockMotion("prev",0,"Diff","O",v:count1)<CR>
onoremap <Plug>(VindentBlockMotion_next) :<C-U>call                                      vindent#BlockMotion("next",0,"Diff","O",v:count1)<CR>
xnoremap <Plug>(VindentBlockMotion_prev) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#BlockMotion("prev",0,"Diff","X",g:vindent_temp)<CR>
xnoremap <Plug>(VindentBlockMotion_next) :<C-U>let g:vindent_temp=v:count1<CR><Esc>:call vindent#BlockMotion("next",0,"Diff","X",g:vindent_temp)<CR>

if exists("g:vindent_blockmotion_prev") | exe 'noremap <silent> '.g:vindent_blockmotion_prev.' <Plug>(VindentBlockMotion_prev)' | endif
if exists("g:vindent_blockmotion_next") | exe 'noremap <silent> '.g:vindent_blockmotion_next.' <Plug>(VindentBlockMotion_next)' | endif
