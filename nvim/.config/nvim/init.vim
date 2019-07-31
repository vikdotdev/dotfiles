if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer --rust-completer' }
" Plug 'chrisbra/Colorizer'
" Plug 'sirtaj/vim-openscad'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components',  { 'branch': 'main' }
" Plug 'dense-analysis/ale'
call plug#end()

let g:airline_powerline_fonts = 1

autocmd BufWritePre * %s/\s\+$//e " deletes trailing spaces on :w

color dracula
filetype plugin on
syntax on
highlight CursorLine ctermbg=237

" general
set nocompatible
set number
set relativenumber
set expandtab
set tabstop=2
set autoindent
set wildmenu
set nostartofline
set showcmd
set wildmode=list:longest,full
set hlsearch
set incsearch
set list
set listchars=trail:·,tab:▸\ ,eol:¬
set cursorline
set colorcolumn=80 " highlight does not seem to work on ColorColumn
set ignorecase
set equalalways
set shiftwidth=2
set smartindent
set clipboard=unnamedplus

" bindings
let mapleader = ","
nnoremap ; :
nnoremap : ;
nnoremap <C-n> :NERDTreeToggle<CR>

" makes tab autocomplete key
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

