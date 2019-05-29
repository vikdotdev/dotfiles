call plug#begin('~/.local/share/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'easymotion/vim-easymotion'
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

color dracula
filetype plugin on
syntax on

map <C-n> :NERDTreeToggle<CR>

set number
set relativenumber
set expandtab
set tabstop=2

set hlsearch
set incsearch

set list
set listchars=trail:·,tab:▸\ ,eol:¬

set ignorecase
set equalalways

set shiftwidth=2

set smartindent

"pastes from a * register
set clipboard=unnamedplus

"enables pastting from win10 clipboard
"map <silent> "=p :r !powershell.exe -Command Get-Clipboard<CR>
"map! <silent> <C-r>= :r !powershell.exe -Command Get-Clipboard<CR>

" I thought this will be better :)
noremap "+p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR>

"" Remove bell on both windows and unix
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"auto InsertEnter * :silent !echo -ne "\e[8 q"
"auto InsertLeave * :silent !echo -ne "\e[1 q"

"fixes the issue with background on scrolling
"by clearing the old background color?
"on windows
"set t_ut=

