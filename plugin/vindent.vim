" indent.vim

nnoremap <silent> <Plug>(VindentMove_N_prev) :call vindent#Move('prev','normal')<CR>
nnoremap <silent> <Plug>(VindentMove_N_next) :call vindent#Move('next','normal')<CR>
xnoremap <silent> <Plug>(VindentMove_X_prev) :call vindent#Move('prev','visual')<CR>
xnoremap <silent> <Plug>(VindentMove_X_next) :call vindent#Move('next','visual')<CR>

xnoremap <silent> <PLug>(VindentObject_X_i) :call vindent#Object('i')<CR>
xnoremap <silent> <PLug>(VindentObject_X_a) :call vindent#Object('a')<CR>
xnoremap <silent> <PLug>(VindentObject_X_I) :call vindent#Object('I')<CR>
onoremap <silent> <PLug>(VindentObject_O_i) :call vindent#Object('i')<CR>
onoremap <silent> <PLug>(VindentObject_O_a) :call vindent#Object('a')<CR>
onoremap <silent> <PLug>(VindentObject_O_I) :call vindent#Object('I')<CR>
