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
vim.cmd([[au WinEnter * setlocal cursorline]])
vim.cmd([[au WinLeave * setlocal nocursorline]])
vim.cmd([[autocmd! WinEnter * setlocal nowinfixheight]])
vim.cmd([[nnoremap Q <nop>]])
-- vim.cmd([[nnoremap o <CR><C-w>p]])
-- vim.cmd([[nnoremap ya :silent! ggyG<C-o><CR>]])
-- vim.cmd('set autochdir')
-- vim.cmd [[vnoremap < <gv]]
-- vim.cmd [[vnoremap > >gv]]

-- Plugin specific commands
-- vim.api.nvim_set_keymap("n", "<C-o>", "<C-o> <bar> :lua require('util').flash_cursorline()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<C-i>", "<C-i> <bar> :lua require('util').flash_cursorline()<CR>", { noremap = true })
-- vim.cmd([[nnoremap <C-o> <C-o> :silent! nohls<CR>]])
-- vim.cmd([[au WinEnter * lua require('util').flash_cursorline()]])
vim.cmd("autocmd BufEnter * lua require('completion').on_attach()")
vim.cmd("autocmd User Startified setlocal cursorline")
vim.cmd([[set completeopt=menuone,noinsert,noselect]])
vim.cmd([[inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"]])
vim.cmd([[inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
vim.cmd([[imap <tab> <Plug>(completion_smart_tab)]])
vim.cmd([[imap <silent> <C-Space> <Plug>(completion_trigger)]])
vim.cmd([[au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['{'])]])
vim.cmd([[au FileType eruby let b:AutoPairs = AutoPairsDefine({'<%' : '%>'})]])
-- vim.cmd [[set foldmethod=expr]]
-- vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
