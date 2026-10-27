" fzf installed via homebrew (Apple Silicon or Intel)
if isdirectory('/opt/homebrew/opt/fzf')
  set rtp+=/opt/homebrew/opt/fzf
elseif isdirectory('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
endif

nnoremap <silent> ,t :Files<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,r :Rg<CR>
nnoremap <silent> ,h :History<CR>
