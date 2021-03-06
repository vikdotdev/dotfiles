local wk = require('whichkey_setup')

vim.g.which_key_disable_default_offset = true

wk.config({
    hide_statusline = false,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
})

-- NOTE: <Cmd> does not work in visual mode, use : instead
local visual_keymap = {
  -- K = {':move \'<-2<CR>gv-gv', 'move line up'},
  -- J = {':move \'>+1<CR>gv-gv', 'move line down'},
  -- r = {':%s/<C-r><C-w>/hello/c<CR>', 'replace selection'},
  r = {
    name = '+repl',
    s = {':lua require("iron").core.visual_send()<CR>', 'send range'}
  },
  l = {
    name = '+lsp',
    f = {':lua vim.lsp.buf.range_formatting()<CR>', 'format range'}
  }
}

local normal_keymap = {
  ['<leader>'] = {'<Cmd>Telescope git_files<CR>', 'file find'},
  q = {
    name = '+quit/session',
    q = {':qa<CR>', 'quit'},
  },
  w = {
    name = '+window',
    h = {'<C-w>h', 'left'},
    l = {'<C-w>l', 'right'},
    k = {'<C-w>k', 'up'},
    j = {'<C-w>j', 'down'},
    H = {'<C-w>H', 'move left'},
    L = {'<C-w>L', 'move right'},
    K = {'<C-w>K', 'move up'},
    J = {'<C-w>J', 'move down'},
    d = {":close<CR>", 'delete'},
    m = {"<C-w>_<C-w>|", 'maximize'},
    o = {":only<CR>", 'only'},
    ['='] = {"<C-w>=", 'equalize'},
    e = {"<C-w>_", 'expand vertically'},
    w = {"<C-w>|", 'widen horizontally'},
    s = {":sbuffer<CR>", 'split'},
    v = {":vertical sb<CR>", 'vertical-split'},
    S = {"<Cmd>resize +3<CR>", 'grow horizontally'},
    V = {"<Cmd>vertical resize +5<CR>", 'grow vertically'},
  },

  e = {
    name = '+edit',
    -- r = {[[y/\V<C-R>=escape(@",'/\')<CR>]], "replace selection"}
  },
  f = {
    name = '+file',
    t = {'<Cmd>NvimTreeToggle<CR>', 'tree'},
    g = {'<Cmd>Telescope live_grep<CR>', 'grep'},
    s = {'<Cmd>w!<CR>', 'save'},
    l = {'<Cmd>NvimTreeFindFile<CR>', 'locate'},
    r = {'<Cmd>Telescope oldfiles<CR>', 'recent'},
    f = {"<Cmd>Telescope file_browser<CR>", 'files'},
    c = {"<Cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--hidden', '--files'}})<CR>", 'from cwd'},
    D = {'<Cmd>call delete(expand("%")) | bdelete!<CR>', 'delete'},
  },
  s = {
    name = '+search',
    c = {'<Cmd>Telescope commands<CR>', 'commands'},
    h = {'<Cmd>Telescope command_history<CR>', 'history'},
    b = {'<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'current buffer'},
  },
  c = {
    name = '+command',
    l = {'<Cmd>Telescope commands<CR>', 'list'},
    h = {'<Cmd>Telescope command_history<CR>', 'history'},
  },
  t = {
    name = '+toggle',
    l = {":lua require('util').toggle_line_numbers()<CR>", 'line numbers'},
    x = {'<Cmd>TSContextToggle<CR>', 'context'},
    c = {":CompletionToggle<CR>", 'completion'},
    -- i = {":IndentLinesToggle<CR>", 'indent guides'},
    C = {":ColorizerToggle<CR>", 'colorizer'},
    R = {":lua require('util').toggle_readonly()<CR>", 'readonly'}, -- needs work
    w = {":set wrap!<CR>", 'word wrap'},
    u = {":UndotreeToggle<CR>", 'undo tree'},
    --   <leader>tc = comments
  },
  o = {
    name = '+open',
    s = {'<Cmd>Startify<CR>', 'startify'},
    t = {'<Cmd>term<CR>', 'terminal here'},
    -- T terminal in this buffer
  },
  g = {
    name = '+git',
    n = {'<Cmd>lua require"gitsigns".next_hunk()<CR>', 'next hunk'},
    p = {'<Cmd>lua require"gitsigns".prev_hunk()<CR>', 'prev hunk'},
    S = {'<Cmd>lua require"gitsigns".stage_hunk()<CR>', 'stage'},
    U = {'<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'undo stage'},
    R = {'<Cmd>lua require"gitsigns".reset_hunk()<CR>', 'reset'},
    d = {'<Cmd>lua require"gitsigns".preview_hunk()<CR>', 'diff'},
    -- B = {'<Cmd>lua require("config/functions").blame_toggle()<CR>', 'blame toggle'},
    B = {'<Cmd>Gitsigns toggle_current_line_blame<CR>', 'blame toggle'},
    b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
    c = {'<Cmd>Telescope git_commits<CR>', 'commits'},
    C = {'<Cmd>Telescope git_bcommits<CR>', 'buffer commits'},
    s = {'<Cmd>Telescope git_status<CR>', 'status'},
  },
  b = {
    name = '+buffer',
    b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
    n = {':BF<CR>', 'next'},
    p = {':BB<CR>', 'previous'},
    l = {':BA<CR>', 'last'},
    u = {":BU<CR>", 'unload'},
    d = {":BD<CR>", 'delete'},
    k = {":BW<CR>", 'wipe'},
  },
  n = {
    name = '+notes',
  },
  h = {
    name = '+help',
    t = {'<Cmd>Telescope help_tags<CR>', 'tags'},
    m = {'<Cmd>Telescope man_pages<CR>', 'man'},
    a = {'<Cmd>Telescope autocommands<CR>', 'autocommands'},
    h = {'<Cmd>Telescope highlights<CR>', 'highlights'},
    k = {'<Cmd>Telescope keymaps<CR>', 'keymaps'},
    s = {'<Cmd>Telescope search_history<CR>', 'search history'},
    f = {'<Cmd>Telescope filetypes<CR>', 'filetypes'},
  },
  m = {
    name = '+maintenance',
    r = {'<Cmd>luafile %<CR>', 'reload file'},
    -- i = {'<Cmd>PackerInstall<CR>', 'install'},
    s = {'<Cmd>PackerSync<CR>', 'sync'},
    -- c = {'<Cmd>PackerClean<CR>', 'clean'},
    -- u = {'<Cmd>PackerUpdate<CR>', 'update'},
  },
  -- p = {
  --   name = '+project',
  -- },
  r = {
    name = '+repl',
    r = {'<Cmd>lua require("iron").core.repeat_cmd()<CR>', 'repeat last command'},
    f = {'<Cmd>lua require("iron").core.focus_on(vim.bo.filetype)<CR>', 'focus'},
    w = {'<Cmd>IronWatchCurrentFile<CR>', 'watch file'},
    u = {'<Cmd>IronUnwatchCurrentFile<CR>', 'unwatch file'},
    s = {'<Cmd>lua require("iron").core.send_line()<CR>', 'send line'},
    h = {'<Cmd>IronReplHere<CR>', 'launch here'},
    l = {'<Cmd>lua require("iron").core.repl_for(vim.bo.filetype)<CR>', 'launch'},
  },
  l = {
    name = '+lsp',
    q = {'<Cmd>LspStop<CR>', 'stop server'},
    Q = {'<Cmd>LspStart<CR>', 'start server'},
    d = {'<Cmd>Telescope lsp_definitions<CR>', 'definition'},
    -- TODO: possibly change this for gg=G
    F = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'format buffer'},
    h = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'hover'},
    s = {'<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'show signature'},
    p = {'<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', 'prev diagnostic'},
    n = {'<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', 'next diagnostic'},
    r = {'<Cmd>Telescope lsp_references<CR>', 'references'},
    R = {'<Cmd>lua vim.lsp.buf.rename()<CR>', 'rename'},
    l = {'<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'diagnose line'},
    D = {'<Cmd>Telescope lsp_document_diagnostics<CR>', 'diagnose'},
    -- bugged, TODO: needs investigation (multiple of the same reference)
    a = {'<Cmd>Telescope lsp_code_actions<CR>', 'action'},
    -- t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', 'type definition'},
    -- i = {'<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation'},
    -- D = {'<Cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration'},
    i = {'<Cmd>LspInfo<CR>', 'info'},
    w = {
      name = '+workspace',
      a = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'add folder'},
      r = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'remove folder'},
      l = {'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'inspect'},
    }
  }
}

wk.register_keymap('leader', normal_keymap)
wk.register_keymap('leader', visual_keymap, { mode = 'v', silent = false })
