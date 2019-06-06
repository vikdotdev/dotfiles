call plug#begin('~/.local/share/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'sirtaj/vim-openscad'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'

call plug#end()

let g:airline_powerline_fonts = 1

" This is used for simple file search
" Usage :find and :b
set path+=**
set wildmenu
set wildignore+=**/node_modules/**,**/.git/**

set colorcolumn=80 " highlight does not seem to work on ColorColumn

color dracula
filetype plugin on
syntax on

nnoremap <C-n> :NERDTreeToggle<CR>

set number
set relativenumber
set expandtab
set tabstop=2

set hlsearch
set incsearch

set list
set listchars=trail:·,tab:▸\ ,eol:¬
set cursorline
highlight CursorLine ctermbg=237


set ignorecase
set equalalways

set shiftwidth=2

set smartindent

set clipboard=unnamedplus

nnoremap ; :
nnoremap : ;

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
