" plugin/indent.vim

if exists("g:loaded_vindent") | finish | endif | let g:loaded_vindent=1

" Define: vindent motion.
nnoremap <silent> <Plug>(VindentMove_N_prev) :<C-U>call vindent#Motion('prev','N',v:count1)<CR>
nnoremap <silent> <Plug>(VindentMove_N_next) :<C-U>call vindent#Motion('next','N',v:count1)<CR>
xnoremap <silent> <Plug>(VindentMove_X_prev) :<C-U>call vindent#Motion('prev','X',v:count1)<CR>
xnoremap <silent> <Plug>(VindentMove_X_next) :<C-U>call vindent#Motion('next','X',v:count1)<CR>
onoremap <silent> <Plug>(VindentMove_O_prev) :<C-U>call vindent#Motion('prev','O',v:count1)<CR>
onoremap <silent> <Plug>(VindentMove_O_next) :<C-U>call vindent#Motion('next','O',v:count1)<CR>

" Define: vindent text objects.
xnoremap <silent> <PLug>(VindentObject_X_ii) :call vindent#Object('ii')<CR>
xnoremap <silent> <PLug>(VindentObject_X_iI) :call vindent#Object('iI')<CR>
xnoremap <silent> <PLug>(VindentObject_X_ai) :call vindent#Object('ai')<CR>
xnoremap <silent> <PLug>(VindentObject_X_aI) :call vindent#Object('aI')<CR>
onoremap <silent> <PLug>(VindentObject_O_ii) :call vindent#Object('ii')<CR>
onoremap <silent> <PLug>(VindentObject_O_iI) :call vindent#Object('iI')<CR>
onoremap <silent> <PLug>(VindentObject_O_ai) :call vindent#Object('ai')<CR>
onoremap <silent> <PLug>(VindentObject_O_aI) :call vindent#Object('aI')<CR>

" Bindkeys: motion
if exists("g:vindent_move_prev")
	execute 'nnoremap <silent> '.g:vindent_move_prev.' <Plug>(VindentMove_N_prev)'
	execute 'xnoremap <silent> '.g:vindent_move_prev.' <Plug>(VindentMove_X_prev)'
	execute 'onoremap <silent> '.g:vindent_move_prev.' <Plug>(VindentMove_O_prev)'
endif
if exists("g:vindent_move_next")
	execute 'nnoremap <silent> '.g:vindent_move_next.' <Plug>(VindentMove_N_next)'
	execute 'xnoremap <silent> '.g:vindent_move_next.' <Plug>(VindentMove_X_next)'
	execute 'onoremap <silent> '.g:vindent_move_next.' <Plug>(VindentMove_O_next)'
endif

" Bindkeys: text object
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
