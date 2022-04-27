" indent.vim

nnoremap <silent> <Plug>(VindentMove_prev_normal) :call vindent#Move('prev','normal')<CR>
xnoremap <silent> <Plug>(VindentMove_prev_visual) :call vindent#Move('prev','visual')<CR>
nnoremap <silent> <Plug>(VindentMove_next_normal) :call vindent#Move('next','normal')<CR>
xnoremap <silent> <Plug>(VindentMove_next_visual) :call vindent#Move('next','visual')<CR>

xnoremap <silent> <PLug>(VindentObject_X_i) :call vindent#Object('i')<CR>
xnoremap <silent> <PLug>(VindentObject_X_a) :call vindent#Object('a')<CR>
xnoremap <silent> <PLug>(VindentObject_X_I) :call vindent#Object('I')<CR>
onoremap <silent> <PLug>(VindentObject_O_i) :call vindent#Object('i')<CR>
onoremap <silent> <PLug>(VindentObject_O_a) :call vindent#Object('a')<CR>
onoremap <silent> <PLug>(VindentObject_O_I) :call vindent#Object('I')<CR>
