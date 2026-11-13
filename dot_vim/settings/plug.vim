call plug#begin()

" appearance
Plug 'itchyny/lightline.vim'

" improvements
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'mikavilpas/yazi.nvim'
endif

call plug#end()
