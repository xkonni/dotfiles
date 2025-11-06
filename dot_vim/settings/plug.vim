call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" appearance
Plug 'itchyny/lightline.vim'
Plug 'chrisbra/unicode.vim'

" completion
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/deoplete.nvim'

" improvements
Plug 'tomtom/tcomment_vim'
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'skwp/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
" fzf native plugin
Plug 'junegunn/fzf'
" fzf.vim
Plug 'junegunn/fzf.vim'
" Required for Gblame in terminal vim
Plug 'godlygeek/csapprox'
Plug 'jlanzarotta/bufexplorer'
" color preview
Plug 'gorodinskiy/vim-coloresque'

" languages
Plug 'wgwoods/vim-systemd-syntax'
Plug 'moon-musick/vim-i3-config-syntax'
Plug 'tpope/vim-markdown'
Plug 'mikeboiko/vim-markdown-folding'
Plug 'kevinoid/vim-jsonc'

" Initialize plugin system
call plug#end()
