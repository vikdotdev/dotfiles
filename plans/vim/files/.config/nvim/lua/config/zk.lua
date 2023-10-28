require("zk").setup({
  picker = "telescope",

  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },

    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

vim.cmd[[
  augroup ConcealMarkdown
    autocmd!
    autocmd FileType markdown setlocal conceallevel=2
  augroup END
]]
