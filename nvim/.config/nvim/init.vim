if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --rust-completer' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'Yggdroot/indentLine'
" Plug 'sirtaj/vim-openscad'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
Plug 'MaxMEllon/vim-jsx-pretty'

call plug#end()

let g:airline_powerline_fonts = 1

autocmd BufWritePre * %s/\s\+$//e

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
