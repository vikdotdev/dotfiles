local neogit = require('neogit')

neogit.setup({
  disable_signs = false,
  disable_context_highlighting = false
})

vim.cmd [[hi def NeogitDiffAddHighlight guibg=#303030 guifg=#5fd787]]
vim.cmd [[hi def NeogitDiffDeleteHighlight guibg=#303030 guifg=#e65b4c]]
vim.cmd [[hi def NeogitDiffContextHighlight guibg=#111111 guifg=#e2e2e2]]
vim.cmd [[hi def NeogitHunkHeader guifg=#eaeaea guibg=#303030]]
vim.cmd [[hi def NeogitHunkHeaderHighlight guifg=#eaeaea guibg=#ba77c9]]
