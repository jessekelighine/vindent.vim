" plugin/indent.vim

if exists("g:loaded_vindent") | finish | endif | let g:loaded_vindent=1

nnoremap <Plug>(VindentMove_N_prev_same) :<C-U>call vindent#Motion('prev','N',v:count1,"Same")<CR>
nnoremap <Plug>(VindentMove_N_next_same) :<C-U>call vindent#Motion('next','N',v:count1,"Same")<CR>
xnoremap <Plug>(VindentMove_X_prev_same) :<C-U>call vindent#Motion('prev','X',v:count1,"Same")<CR>
xnoremap <Plug>(VindentMove_X_next_same) :<C-U>call vindent#Motion('next','X',v:count1,"Same")<CR>
onoremap <Plug>(VindentMove_O_prev_same) :<C-U>call vindent#Motion('prev','O',v:count1,"Same")<CR>
onoremap <Plug>(VindentMove_O_next_same) :<C-U>call vindent#Motion('next','O',v:count1,"Same")<CR>
nnoremap <Plug>(VindentMove_N_prev_more) :<C-U>call vindent#Motion('prev','N',v:count1,"More")<CR>
nnoremap <Plug>(VindentMove_N_next_more) :<C-U>call vindent#Motion('next','N',v:count1,"More")<CR>
xnoremap <Plug>(VindentMove_X_prev_more) :<C-U>call vindent#Motion('prev','X',v:count1,"More")<CR>
xnoremap <Plug>(VindentMove_X_next_more) :<C-U>call vindent#Motion('next','X',v:count1,"More")<CR>
onoremap <Plug>(VindentMove_O_prev_more) :<C-U>call vindent#Motion('prev','O',v:count1,"More")<CR>
onoremap <Plug>(VindentMove_O_next_more) :<C-U>call vindent#Motion('next','O',v:count1,"More")<CR>
nnoremap <Plug>(VindentMove_N_prev_less) :<C-U>call vindent#Motion('prev','N',v:count1,"Less")<CR>
nnoremap <Plug>(VindentMove_N_next_less) :<C-U>call vindent#Motion('next','N',v:count1,"Less")<CR>
xnoremap <Plug>(VindentMove_X_prev_less) :<C-U>call vindent#Motion('prev','X',v:count1,"Less")<CR>
xnoremap <Plug>(VindentMove_X_next_less) :<C-U>call vindent#Motion('next','X',v:count1,"Less")<CR>
onoremap <Plug>(VindentMove_O_prev_less) :<C-U>call vindent#Motion('prev','O',v:count1,"Less")<CR>
onoremap <Plug>(VindentMove_O_next_less) :<C-U>call vindent#Motion('next','O',v:count1,"Less")<CR>
nnoremap <Plug>(VindentMove_N_prev_diff) :<C-U>call vindent#Motion('prev','N',v:count1,"Diff")<CR>
nnoremap <Plug>(VindentMove_N_next_diff) :<C-U>call vindent#Motion('next','N',v:count1,"Diff")<CR>
xnoremap <Plug>(VindentMove_X_prev_diff) :<C-U>call vindent#Motion('prev','X',v:count1,"Diff")<CR>
xnoremap <Plug>(VindentMove_X_next_diff) :<C-U>call vindent#Motion('next','X',v:count1,"Diff")<CR>
onoremap <Plug>(VindentMove_O_prev_diff) :<C-U>call vindent#Motion('prev','O',v:count1,"Diff")<CR>
onoremap <Plug>(VindentMove_O_next_diff) :<C-U>call vindent#Motion('next','O',v:count1,"Diff")<CR>

if exists("g:vindent_motion_same_prev")
	execute 'nnoremap <silent> '.g:vindent_motion_same_prev.' <Plug>(VindentMove_N_prev_same)'
	execute 'xnoremap <silent> '.g:vindent_motion_same_prev.' <Plug>(VindentMove_X_prev_same)'
	execute 'onoremap <silent> '.g:vindent_motion_same_prev.' <Plug>(VindentMove_O_prev_same)'
endif
if exists("g:vindent_motion_same_next")
	execute 'nnoremap <silent> '.g:vindent_motion_same_next.' <Plug>(VindentMove_N_next_same)'
	execute 'xnoremap <silent> '.g:vindent_motion_same_next.' <Plug>(VindentMove_X_next_same)'
	execute 'onoremap <silent> '.g:vindent_motion_same_next.' <Plug>(VindentMove_O_next_same)'
endif

if exists("g:vindent_motion_less_prev")
	execute 'nnoremap <silent> '.g:vindent_motion_less_prev.' <Plug>(VindentMove_N_prev_less)'
	execute 'xnoremap <silent> '.g:vindent_motion_less_prev.' <Plug>(VindentMove_X_prev_less)'
	execute 'onoremap <silent> '.g:vindent_motion_less_prev.' <Plug>(VindentMove_O_prev_less)'
endif
if exists("g:vindent_motion_less_next")
	execute 'nnoremap <silent> '.g:vindent_motion_less_next.' <Plug>(VindentMove_N_next_less)'
	execute 'xnoremap <silent> '.g:vindent_motion_less_next.' <Plug>(VindentMove_X_next_less)'
	execute 'onoremap <silent> '.g:vindent_motion_less_next.' <Plug>(VindentMove_O_next_less)'
endif

if exists("g:vindent_motion_more_prev")
	execute 'nnoremap <silent> '.g:vindent_motion_more_prev.' <Plug>(VindentMove_N_prev_more)'
	execute 'xnoremap <silent> '.g:vindent_motion_more_prev.' <Plug>(VindentMove_X_prev_more)'
	execute 'onoremap <silent> '.g:vindent_motion_more_prev.' <Plug>(VindentMove_O_prev_more)'
endif
if exists("g:vindent_motion_more_next")
	execute 'nnoremap <silent> '.g:vindent_motion_more_next.' <Plug>(VindentMove_N_next_more)'
	execute 'xnoremap <silent> '.g:vindent_motion_more_next.' <Plug>(VindentMove_X_next_more)'
	execute 'onoremap <silent> '.g:vindent_motion_more_next.' <Plug>(VindentMove_O_next_more)'
endif

if exists("g:vindent_motion_diff_prev")
	execute 'nnoremap <silent> '.g:vindent_motion_diff_prev.' <Plug>(VindentMove_N_prev_diff)'
	execute 'xnoremap <silent> '.g:vindent_motion_diff_prev.' <Plug>(VindentMove_X_prev_diff)'
	execute 'onoremap <silent> '.g:vindent_motion_diff_prev.' <Plug>(VindentMove_O_prev_diff)'
endif
if exists("g:vindent_motion_diff_next")
	execute 'nnoremap <silent> '.g:vindent_motion_diff_next.' <Plug>(VindentMove_N_next_diff)'
	execute 'xnoremap <silent> '.g:vindent_motion_diff_next.' <Plug>(VindentMove_X_next_diff)'
	execute 'onoremap <silent> '.g:vindent_motion_diff_next.' <Plug>(VindentMove_O_next_diff)'
endif

xnoremap <Plug>(VindentObject_X_ii) :call vindent#Object('ii')<CR>
xnoremap <Plug>(VindentObject_X_iI) :call vindent#Object('iI')<CR>
xnoremap <Plug>(VindentObject_X_ai) :call vindent#Object('ai')<CR>
xnoremap <Plug>(VindentObject_X_aI) :call vindent#Object('aI')<CR>
onoremap <Plug>(VindentObject_O_ii) :call vindent#Object('ii')<CR>
onoremap <Plug>(VindentObject_O_iI) :call vindent#Object('iI')<CR>
onoremap <Plug>(VindentObject_O_ai) :call vindent#Object('ai')<CR>
onoremap <Plug>(VindentObject_O_aI) :call vindent#Object('aI')<CR>

if exists("g:vindent_object_ii")
	execute 'xnoremap <silent> '.g:vindent_object_ii.' <PLug>(VindentObject_X_ii)'
	execute 'onoremap <silent> '.g:vindent_object_ii.' <PLug>(VindentObject_O_ii)'
endif

if exists("g:vindent_object_iI")
	execute 'xnoremap <silent> '.g:vindent_object_iI.' <PLug>(VindentObject_X_iI)'
	execute 'onoremap <silent> '.g:vindent_object_iI.' <PLug>(VindentObject_O_iI)'
endif

if exists("g:vindent_object_ai")
	execute 'xnoremap <silent> '.g:vindent_object_ai.' <PLug>(VindentObject_X_ai)'
	execute 'onoremap <silent> '.g:vindent_object_ai.' <PLug>(VindentObject_O_ai)'
endif

if exists("g:vindent_object_aI")
	execute 'xnoremap <silent> '.g:vindent_object_aI.' <PLug>(VindentObject_X_aI)'
	execute 'onoremap <silent> '.g:vindent_object_aI.' <PLug>(VindentObject_O_aI)'
endif
