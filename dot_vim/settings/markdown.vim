"" If you want to enable fenced code block syntax highlighting in your markdown documents
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

"" To disable markdown syntax concealing add the following to your vimrc:
" let g:markdown_syntax_conceal = 0

"" Syntax highlight is synchronized in 50 lines. It may cause collapsed highlighting at large fenced code block. In the case, please set larger value in your vimrc:
"" Note that setting too large value may cause bad performance on highlighting.
let g:markdown_minlines = 100
