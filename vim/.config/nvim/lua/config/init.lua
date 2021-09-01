local indent = 2
vim.o.timeoutlen = 400
vim.o.number = false
vim.o.relativenumber = false
vim.o.shiftwidth = indent
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = indent
vim.o.expandtab = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 10
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest'
vim.o.clipboard ='unnamed,unnamedplus'
vim.o.fileencoding ='utf-8'
vim.o.ruler = true
vim.o.cursorline = true
vim.o.showtabline = 1
vim.o.mouse = 'a'
vim.g.updatetime = 600

vim.cmd('set termguicolors')

require('config/lsp')
require('config/which-key')
require('config/colorizer')
require('config/telescope')
require('config/iron')
require('config/galaxyline')
require('config/gitsigns')
require('config/nvim_tree')
require('config/startify')
require('config/treesitter')
require('config/autopairs')

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
vim.cmd('set textwidth=0')
vim.cmd('set noshowmode')
vim.cmd('colorscheme palenight')
vim.cmd('set colorcolumn=90')
vim.cmd('set cursorline')
vim.cmd('set iskeyword-=_')
vim.cmd('set undofile')
vim.cmd(':tnoremap <Esc> <C-\\><C-n>')
vim.cmd("autocmd VimResized * wincmd =")
vim.cmd([[nnoremap <Esc> :silent! nohls<CR>]])
vim.cmd([[vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>]])
vim.cmd([[autocmd! WinEnter * setlocal nowinfixheight]])
vim.cmd([[nnoremap Q <nop>]])
vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])
-- vim.cmd([[nnoremap ya :silent! ggyG<C-o><CR>]])
vim.cmd("autocmd BufEnter * lua require('completion').on_attach()")
vim.cmd([[set completeopt=menuone,noinsert,noselect]])
vim.cmd([[inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"]])
vim.cmd([[inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
vim.cmd([[imap <tab> <Plug>(completion_smart_tab)]])
vim.cmd([[imap <silent> <C-Space> <Plug>(completion_trigger)]])
vim.cmd([[au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['{'])]])
vim.cmd([[au FileType eruby let b:AutoPairs = AutoPairsDefine({'<%' : '%>'})]])

require('util').create_augroups({
  CursorLine = {
    "VimEnter * setlocal cursorline",
    "WinEnter * setlocal cursorline",
    "BufWinEnter * setlocal cursorline",
    "WinLeave * setlocal nocursorline"
  }
})

