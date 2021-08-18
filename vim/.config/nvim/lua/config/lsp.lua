require('lspconfig').solargraph.setup({
  autoformat = true, -- EXPERIMENTAL
  on_attach = require('completion').on_attach,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
})

require('lspconfig').clangd.setup({})

local sumneko_root_path = vim.fn.stdpath('cache')..'/../../Repositories/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

require('lspconfig').sumneko_lua.setup({
  on_attach = require('completion').on_attach,
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
        globals = {'vim'},
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
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

require('lspconfig').denols.setup({})

require('lspconfig').jsonls.setup({})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  }
)


local ruby_capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.protocol.make_client_capabilities().callHierarchy.dynamicRegistration = true
vim.lsp.protocol.make_client_capabilities().textDocument.codeAction = { dynamicRegistration = true; }


require('lspconfig').bashls.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').cssls.setup({
  capabilities = capabilities,
})


local html_capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = html_capabilities,
}

require'lspconfig'.yamlls.setup{}

-- require'lspconfig'.sqlls.setup{
--   cmd = {"sql-language-server", "up", "--method", "stdio"};
-- }
