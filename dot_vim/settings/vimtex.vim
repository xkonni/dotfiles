" latex
autocmd BufEnter *.tex call SetTex()
let g:tex_flavor = 'latex'

" update pdf
" function! UpdatePdf(status)
"   echom "status" . a:status
"   if !a:status
"     return
"   endif
" endfunction

" latex stuff
function! SetTex()
  " automatically break lines
  set tw=90
  set sidescroll=0
  set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.idx
  set wildignore+=*.ilg,*.ind,*.nlo,*.out,*.toc
  set wildignore+=*.pdf,*.log

  " vimtex

  let g:vimtex_view_method='general'
  if system('uname') =~# 'Darwin'
    let g:vimtex_view_general_viewer
          \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'
  else
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_general_options = '--synctex-forward @line:1:@tex @pdf'
  end
  let g:vimtex_latexmk_background = 1
  let g:vimtex_latexmk_continuous = 0
  let g:vimtex_latexmk_callback = 0
  " added bibtex, src-specials and synctex=1 to default options
  " let g:vimtex_latexmk_options
  "       \ = '-pdf -verbose -file-line-error -interaction=nonstopmode -bibtex -src-specials -synctex=1'
  " let g:vimtex_quickfix_autojump = 1
  " open quickfix on errors, dont make it the active window
  let g:vimtex_quickfix_mode = 2
  " dont open quickfix on warnings
  let g:vimtex_quickfix_open_on_warning = 0
  " ignore all warnings
  let g:vimtex_quickfix_ignore_all_warnings=1
  " ignore some warnings
  let g:vimtex_quickfix_ignored_warnings = [
        \ 'Underfull',
        \ 'Overfull',
        \ 'specifier changed to',
        \ 'Package pagecolor Warning:',
        \ 'Package polyglossia Warning:',
        \ 'Package csquotes Warning:',
        \ 'Package natbib Warning:',
        \ 'Class scrartcl Warning:'
        \ ]

  " let g:vimtex_latexmk_callback_hooks = ['UpdatePdf']

  nmap <Leader>lc :VimtexClean<CR>
  nmap <Leader>ll :VimtexCompileSS<CR><CR>
  nmap <Leader>lv :VimtexView<CR>
  " nmap <Leader>lu :call UpdatePdf(1)<CR>

  call vimtex#imaps#add_map({ 'lhs' : 'a', 'rhs' : '\"a', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 'o', 'rhs' : '\"o', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 'u', 'rhs' : '\"u', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 'A', 'rhs' : '\"A', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 'O', 'rhs' : '\"O', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 'U', 'rhs' : '\"U', 'wrapper' : 'vimtex#imaps#wrap_trivial' })
  call vimtex#imaps#add_map({ 'lhs' : 's', 'rhs' : '{\ss}', 'wrapper' : 'vimtex#imaps#wrap_trivial' })

  syn keyword texTodo contained NOTE
endfunction
