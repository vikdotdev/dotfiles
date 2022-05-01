local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').solargraph.setup({
  capabilities = capabilities,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
})

require('lspconfig').clangd.setup({})

local sumneko_root_path = vim.fn.expand('$HOME/.local/bin/sumneko_lua')
local sumneko_binary = vim.fn.expand(sumneko_root_path .. '/bin/lua-language-server')

require('lspconfig').sumneko_lua.setup({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'awesome', 'screen', 'root', 'client'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

require('lspconfig').jsonls.setup {
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

require('lspconfig').denols.setup({
  capabilities = capabilities
})

require('lspconfig').jsonls.setup({
  capabilities = capabilities
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  }
)

require('lspconfig').bashls.setup({
  capabilities = capabilities
})

require('lspconfig').cssls.setup({
  capabilities = capabilities,
})

require'lspconfig'.html.setup {
  capabilities = capabilities
}

require'lspconfig'.yamlls.setup({
  capabilities = capabilities
})

require'lspconfig'.diagnosticls.setup({
  capabilities = capabilities
})

require'lspconfig'.dockerls.setup({
  capabilities = capabilities
})

require'lspconfig'.tailwindcss.setup({})
