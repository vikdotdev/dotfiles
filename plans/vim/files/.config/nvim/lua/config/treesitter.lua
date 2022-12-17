require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  indent = {
    enable = true
  },
  folding = {
    enable = true
  },
  context_commentstring = {
    enable = true
  }
})

