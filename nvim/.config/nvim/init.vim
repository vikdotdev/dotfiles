if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jremmen/vim-ripgrep'
" Plug 'chrisbra/Colorizer'
" Plug 'sirtaj/vim-openscad'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'styled-components/vim-styled-components',  { 'branch': 'main' }
Plug 'dense-analysis/ale'
Plug 'ngmy/vim-rubocop'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vifm/vifm.vim'
Plug 'slim-template/vim-slim'
" Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'

call plug#end()

" let g:rg_command = 'rg --vimgrep -S'
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,md,styl,jade,html,slim,config,py,cpp,c,go,hs,rb,erb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* FinFile call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

let g:airline_powerline_fonts = 1

let g:fzf_buffers_jump = 1
" Set specific linters
let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
" Disable ALE auto highlights
let g:ale_set_highlights = 0
let g:vimrubocop_keymap = 0

autocmd BufWritePre * %s/\s\+$//e " deletes trailing spaces on :w

" saves and loads folds
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

color dracula
filetype plugin on
syntax on
filetype plugin indent on
highlight CursorLine ctermbg=237

" custom commands
nnoremap ,cd :pu =strftime('%A %d')<CR>i--- <ESC>$a ---<CR><ESC>
nnoremap ,cw :pu =strftime('W%W %b %m/%Y')<CR>i::: <ESC>$a :::<CR>::: END :::<ESC>k,cd

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
" git
map <silent> <leader>nc /^\(<\{7\}\\|>\{7\}\\|=\{7\}\\|\|\{7\}\)\( \\|$\)<CR>

" file/buffer manipulations
nnoremap <leader>fm :Vifm<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fif :FinFile<CR>
nnoremap <leader>bl :Buffers<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bt :bufdo tab split<CR>

" tab switching
nnoremap <leader>r gt<CR>
nnoremap <leader>e gT<CR>
nnoremap <leader>r gt<CR>
" pane shortcuts, maximaze and minimize just as in xmonad layout
nnoremap <leader>wm <C-w><bar><C-w>_k<CR>
nnoremap <leader>wn <C-w>=k<CR>

" show blame information
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

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

