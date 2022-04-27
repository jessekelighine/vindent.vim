" plugin/indent.vim

" Define: vindent motion.
nnoremap <silent> <Plug>(VindentMove_N_prev) :call vindent#Move('prev','N')<CR>
nnoremap <silent> <Plug>(VindentMove_N_next) :call vindent#Move('next','N')<CR>
xnoremap <silent> <Plug>(VindentMove_X_prev) :call vindent#Move('prev','X')<CR>
xnoremap <silent> <Plug>(VindentMove_X_next) :call vindent#Move('next','X')<CR>
onoremap <silent> <Plug>(VindentMove_O_prev) :call vindent#Move('prev','O')<CR>
onoremap <silent> <Plug>(VindentMove_O_next) :call vindent#Move('next','O')<CR>
" Define: vindent text objects.
xnoremap <silent> <PLug>(VindentObject_X_i) :call vindent#Object('i')<CR>
xnoremap <silent> <PLug>(VindentObject_X_a) :call vindent#Object('a')<CR>
xnoremap <silent> <PLug>(VindentObject_X_I) :call vindent#Object('I')<CR>
onoremap <silent> <PLug>(VindentObject_O_i) :call vindent#Object('i')<CR>
onoremap <silent> <PLug>(VindentObject_O_a) :call vindent#Object('a')<CR>
onoremap <silent> <PLug>(VindentObject_O_I) :call vindent#Object('I')<CR>

" Default Keybindings: vindent motion.
nnoremap <silent> [l <Plug>(VindentMove_N_prev)
nnoremap <silent> ]l <Plug>(VindentMove_N_next)
xnoremap <silent> [l <Plug>(VindentMove_X_prev)
xnoremap <silent> ]l <Plug>(VindentMove_X_next)
onoremap <silent> [l <Plug>(VindentMove_O_prev)
onoremap <silent> ]l <Plug>(VindentMove_O_next)
" Default Keybindings: vindent text object.
xnoremap <silent> ii <PLug>(VindentObject_X_i)
xnoremap <silent> ai <PLug>(VindentObject_X_a)
xnoremap <silent> aI <PLug>(VindentObject_X_I)
onoremap <silent> ii <PLug>(VindentObject_O_i)
onoremap <silent> ai <PLug>(VindentObject_O_a)
onoremap <silent> aI <PLug>(VindentObject_O_I)
