call plug#begin('~/.local/share/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'

call plug#end()

color dracula

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

"enables yanking from vim to win10 clipboard
set clipboard=unnamedplus

"enables pastting from win10 clipboard
map <silent> "=p :r !powershell.exe -Command Get-Clipboard<CR>
map! <silent> <C-r>= :r !powershell.exe -Command Get-Clipboard<CR>

" I thought this will be better :)
noremap "+p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')<CR>

"" Remove bell on both windows and unix

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"auto InsertEnter * :silent !echo -ne "\e[8 q"
"auto InsertLeave * :silent !echo -ne "\e[1 q"

"fixes the issue with background on scrolling
"by clearing the old background color?
set t_ut=

"map <silent> <C-h> :call WinMove('h')<CR>
"map <silent> <C-j> :call WinMove('j')<CR>
"map <silent> <C-k> :call WinMove('k')<CR>
"map <silent> <C-l> :call WinMove('l')<CR>

"function! WinMove(key)
"  let t:curwin = winnr()
"  exec "wincmd ".a:key
"  if (t:curwin == winnr())
"    "if (match(a:key,'[jk]'))
"    "  wincmd v
"    "else
"    "  wincmd s
"    "endif
"    exec "wincmd ".a:key
"  endif
"endfunction
