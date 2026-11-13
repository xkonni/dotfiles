" vim: ft=vim
if !has('nvim') | finish | endif

lua << EOF
local ok, yazi = pcall(require, "yazi")
if ok then yazi.setup() end
EOF

nnoremap <silent> <leader>y :Yazi<CR>
nnoremap <silent> <leader>Y :Yazi cwd<CR>
