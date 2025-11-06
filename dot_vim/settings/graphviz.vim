" graphviz
let g:WMGraphviz_output="png"
if system('uname') =~# 'Darwin'
  let g:WMGraphviz_viewer="open"
else
  let g:WMGraphviz_viewer="feh"
end
autocmd BufEnter *.gv nnoremap <Leader>ll :GraphvizCompile<CR>
autocmd BufEnter *.gv nnoremap <Leader>lv :GraphvizShow<CR><CR>
