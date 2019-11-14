if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'chrisbra/Colorizer'
" Plug 'sirtaj/vim-openscad'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'styled-components/vim-styled-components',  { 'branch': 'main' }
" Plug 'dense-analysis/ale'
Plug 'w0rp/ale'
Plug 'ngmy/vim-rubocop'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vifm/vifm.vim'
Plug 'slim-template/vim-slim'
call plug#end()

let g:airline_powerline_fonts = 1
let g:fzf_buffers_jump = 1
" Set specific linters
let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
" Disable ALE auto highlights
" let g:ale_set_highlights = 0

autocmd BufWritePre * %s/\s\+$//e " deletes trailing spaces on :w

color dracula
filetype plugin on
syntax on
filetype plugin indent on
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
" file/buffer manipulations
nnoremap <leader>fm :Vifm<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>bl :Buffers<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bar :silent! bufdo e<CR>

" tab switching
nnoremap <leader>tl gt<CR>
nnoremap <leader>th gT<CR>
" pane shortcuts, maximaze and minimize just as in xmonad layout
nnoremap <leader>wm <C-w><bar><C-w>_k<CR>
nnoremap <leader>wn <C-w>=k<CR>

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

