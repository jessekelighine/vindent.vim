" plugin/indent.vim

if exists("g:loaded_vindent") | finish | endif | let g:loaded_vindent=1

nnoremap <Plug>(VindentMotion_prev_same) :<C-U>call vindent#Motion('prev','N',v:count1,"Same")<CR>
nnoremap <Plug>(VindentMotion_next_same) :<C-U>call vindent#Motion('next','N',v:count1,"Same")<CR>
xnoremap <Plug>(VindentMotion_prev_same) :<C-U>call vindent#Motion('prev','X',v:count1,"Same")<CR>
xnoremap <Plug>(VindentMotion_next_same) :<C-U>call vindent#Motion('next','X',v:count1,"Same")<CR>
onoremap <Plug>(VindentMotion_prev_same) :<C-U>call vindent#Motion('prev','O',v:count1,"Same")<CR>
onoremap <Plug>(VindentMotion_next_same) :<C-U>call vindent#Motion('next','O',v:count1,"Same")<CR>
nnoremap <Plug>(VindentMotion_prev_more) :<C-U>call vindent#Motion('prev','N',v:count1,"More")<CR>
nnoremap <Plug>(VindentMotion_next_more) :<C-U>call vindent#Motion('next','N',v:count1,"More")<CR>
xnoremap <Plug>(VindentMotion_prev_more) :<C-U>call vindent#Motion('prev','X',v:count1,"More")<CR>
xnoremap <Plug>(VindentMotion_next_more) :<C-U>call vindent#Motion('next','X',v:count1,"More")<CR>
onoremap <Plug>(VindentMotion_prev_more) :<C-U>call vindent#Motion('prev','O',v:count1,"More")<CR>
onoremap <Plug>(VindentMotion_next_more) :<C-U>call vindent#Motion('next','O',v:count1,"More")<CR>
nnoremap <Plug>(VindentMotion_prev_less) :<C-U>call vindent#Motion('prev','N',v:count1,"Less")<CR>
nnoremap <Plug>(VindentMotion_next_less) :<C-U>call vindent#Motion('next','N',v:count1,"Less")<CR>
xnoremap <Plug>(VindentMotion_prev_less) :<C-U>call vindent#Motion('prev','X',v:count1,"Less")<CR>
xnoremap <Plug>(VindentMotion_next_less) :<C-U>call vindent#Motion('next','X',v:count1,"Less")<CR>
onoremap <Plug>(VindentMotion_prev_less) :<C-U>call vindent#Motion('prev','O',v:count1,"Less")<CR>
onoremap <Plug>(VindentMotion_next_less) :<C-U>call vindent#Motion('next','O',v:count1,"Less")<CR>
nnoremap <Plug>(VindentMotion_prev_diff) :<C-U>call vindent#Motion('prev','N',v:count1,"Diff")<CR>
nnoremap <Plug>(VindentMotion_next_diff) :<C-U>call vindent#Motion('next','N',v:count1,"Diff")<CR>
xnoremap <Plug>(VindentMotion_prev_diff) :<C-U>call vindent#Motion('prev','X',v:count1,"Diff")<CR>
xnoremap <Plug>(VindentMotion_next_diff) :<C-U>call vindent#Motion('next','X',v:count1,"Diff")<CR>
onoremap <Plug>(VindentMotion_prev_diff) :<C-U>call vindent#Motion('prev','O',v:count1,"Diff")<CR>
onoremap <Plug>(VindentMotion_next_diff) :<C-U>call vindent#Motion('next','O',v:count1,"Diff")<CR>

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

if exists("g:vindent_object_ii") | exe 'xnoremap <silent> '.g:vindent_object_ii.' <PLug>(VindentObject_ii)' | exe 'onoremap <silent> '.g:vindent_object_ii.' <PLug>(VindentObject_ii)' | endif
if exists("g:vindent_object_iI") | exe 'xnoremap <silent> '.g:vindent_object_iI.' <PLug>(VindentObject_iI)' | exe 'onoremap <silent> '.g:vindent_object_iI.' <PLug>(VindentObject_iI)' | endif
if exists("g:vindent_object_ai") | exe 'xnoremap <silent> '.g:vindent_object_ai.' <PLug>(VindentObject_ai)' | exe 'onoremap <silent> '.g:vindent_object_ai.' <PLug>(VindentObject_ai)' | endif
if exists("g:vindent_object_aI") | exe 'xnoremap <silent> '.g:vindent_object_aI.' <PLug>(VindentObject_aI)' | exe 'onoremap <silent> '.g:vindent_object_aI.' <PLug>(VindentObject_aI)' | endif
