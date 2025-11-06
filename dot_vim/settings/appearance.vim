" APPEARANCE

" gui
if has("gui_running")
  set guifont=Hack\ 11
  set guioptions-=r
  set guioptions-=L
  set guioptions-=m
  " osX
  if system('uname') =~# 'Darwin'
    " set guifont=Hack\ Regular:h11
    set macligatures
    set guifont=Fira\ Code:h12
    set transparency=10
    set guioptions-=m
  " Linux
  else
    set guifont=Hack\ 11
    set guioptions-=T
  end
  map <C-T> :TComment<CR>
  imap <C-T> <Esc>:TComment<CR>i
" terminal
else
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  let g:CSApprox_loaded=1
end
" general
set background=dark
colorscheme solarized
