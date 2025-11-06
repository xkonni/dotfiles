" vim: ft=vim
"Move back and forth through previous and next buffers with ,z and ,x
nnoremap <silent> ,z :bp<CR>
nnoremap <silent> ,x :bn<CR>
" comment block
noremap <silent> <c-/> :TComment<CR>
" enable spell check
map <F5> :setlocal spell! spelllang=en_us<CR>

