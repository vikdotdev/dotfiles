autocmd BufWritePre * %s/\s\+$//e " deletes trailing spaces on :w

filetype plugin on
syntax on
filetype plugin indent on
highlight CursorLine ctermbg=237

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
set spellfile=~/.config/nvim/.spellfile.add
