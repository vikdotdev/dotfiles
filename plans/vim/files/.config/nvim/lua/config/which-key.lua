local wk = require('which-key')

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20
    }
  },
  ignore_missing = true
})

local visual_keymap = {
  p = {
    name = '+prettify',
    j = {':!jq<CR>', 'json'},
  },
  l = {
    name = '+lsp',
    f = {':lua vim.lsp.buf.range_formatting()<CR>', 'format range'}
  }
}

local normal_keymap = {
  ['<leader>'] = {"<Cmd>lua require('util').telescope_git_files()<CR>", 'file find'},
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
    p = {'<C-w>p', 'previous'},
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
  f = {
    name = '+file',
    g = {"<Cmd>lua require('util').telescope_grep()<CR>", 'grep'},
    G = {"<Cmd>lua require('util').telescope_grep({ grep_open_files = true })<CR>", 'grep open files'},
    s = {'<Cmd>w!<CR>', 'save'},
    l = {'<Cmd>NvimTreeFindFile<CR>', 'locate'},
    r = {'<Cmd>Telescope oldfiles<CR>', 'recent'},
    t = {'<Cmd>NvimTreeToggle<CR>', 'file tree'},
    c = {"<Cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--hidden', '--files'}})<CR>", 'from cwd'},
    D = {'<Cmd>call delete(expand("%")) | bdelete!<CR>', 'delete'},
    n = {'<Cmd>next<CR>', 'next'},
    p = {'<Cmd>previous<CR>', 'previous'},
  },
  s = {
    name = '+search',
    s = {"<Cmd>lua require('telescope.builtin').grep_string()<CR>", 'string under cursor'},
    C = {'<Cmd>Telescope commands<CR>', 'commands'},
    c = {'<Cmd>noh<CR>', 'clear'},
    h = {'<Cmd>Telescope command_history<CR>', 'history'},
    b = {'<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'current buffer'},
    l = {"<Cmd>lua require('telescope.builtin').resume()<CR>", 'resume last'},
  },
  y = {
    name = '+yank',
    p = {"<Cmd>lua require('util').yank_filepath()<CR>", 'absolute path'},
    d = {"<Cmd>lua require('util').yank_dirpath()<CR>", 'absolute dir path'},
    f = {"<Cmd>lua require('util').yank_filename()<CR>", 'file name'},
    r = {"<Cmd>lua require('util').yank_filepath_from_repo()<CR>", 'repo file path'},
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
    C = {":CompletionToggle<CR>", 'completion'},
    i = {":lua print('NOT IMPLEMENTED')<CR>", 'indent guides'},
    c = {":ColorizerToggle<CR>", 'colorizer'},
    R = {":lua require('util').toggle_readonly()<CR>", 'readonly'},
    w = {":set wrap!<CR>", 'word wrap'},
    u = {":UndotreeToggle<CR>", 'undo tree'},
    s = {":lua require('util').toggle_spell()<CR>", 'spell check'},
    ['/'] = {":lua print('NOT IMPLEMENTED')<CR>", 'comments'},
  },
  o = {
    name = '+open',
    s = {'<Cmd>Startify<CR>', 'startify'},
    t = {'<Cmd>new tab<CR>', 'new tab'},
    q = {'<Cmd>copen<CR>', 'quickfix list'},
  },
  g = {
    name = '+git',
    n = {'<Cmd>lua require"gitsigns".next_hunk()<CR>', 'next hunk'},
    p = {'<Cmd>lua require"gitsigns".prev_hunk()<CR>', 'prev hunk'},
    s = {'<Cmd>lua require"gitsigns".stage_hunk()<CR>', 'stage'},
    U = {'<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'undo stage'},
    R = {'<Cmd>lua require"gitsigns".reset_hunk()<CR>', 'reset'},
    d = {'<Cmd>lua require"gitsigns".preview_hunk()<CR>', 'diff'},
    v = {'<Cmd>lua require"gitsigns.actions".select_hunk()<CR>', 'visual select hunk'},
    B = {'<Cmd>Gitsigns toggle_current_line_blame<CR>', 'blame toggle'},
    b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
    c = {'<Cmd>Telescope git_commits<CR>', 'commits'},
    C = {'<Cmd>Telescope git_bcommits<CR>', 'buffer commits'},
    g = {'<Cmd>Telescope git_status<CR>', 'status'},
    o = {'<Cmd>lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").open_in_browser})<CR>', 'open remote line url'},
    r = {'<Cmd>lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").copy_to_clipboard})<CR>', 'copy remote line url'}
  },
  b = {
    name = '+buffer',
    b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
    n = {':BufNavNext<CR>', 'next'},
    p = {':BufNavPrev<CR>', 'previous'},
    l = {':b#<CR>', 'last'},
    k = {":BufDel<CR>", 'kill'},
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
    b = {'<Cmd>Telescope builtin<CR>', 'telescope built-ins'},
  },
  m = {
    name = '+maintenance',
    r = {'<Cmd>luafile %<CR>', 'reload lua buffer'},
    s = {'<Cmd>PackerSync<CR>', 'sync plugins'},
    i = {'<Cmd>TSInstall all<CR>', 'install all treesitter parsers'},
    n = {'<Cmd>TSNodeUnderCursor<CR>', 'show node under cursor'},
    h = {'<Cmd>TSHighlightCapturesUnderCursor<CR>', 'show highlight group under cursor'},
    c = {'<Cmd>PackerCompile<CR>', 'compile'}
  },
  l = {
    name = '+lsp',
    q = {'<Cmd>LspStop<CR>', 'stop server'},
    Q = {'<Cmd>LspStart<CR>', 'start server'},
    d = {'<Cmd>Telescope lsp_definitions<CR>', 'definition'},
    F = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'format buffer'},
    h = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'hover'},
    s = {'<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'show signature'},
    p = {'<Cmd>lua vim.diagnostic.goto_prev()<CR>', 'prev diagnostic'},
    n = {'<Cmd>lua vim.diagnostic.goto_next()<CR>', 'next diagnostic'},
    r = {'<Cmd>Telescope lsp_references<CR>', 'references'},
    R = {'<Cmd>lua vim.lsp.buf.rename()<CR>', 'rename'},
    l = {'<Cmd>lua vim.diagnostic.open_float()<CR>', 'diagnose line'},
    g = {'<Cmd>Telescope lsp_document_diagnostics<CR>', 'diagnose'},
    a = {'<Cmd>Telescope lsp_code_actions<CR>', 'action'},
    i = {'<Cmd>LspInfo<CR>', 'info'},
    w = {
      name = '+workspace',
      a = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'add folder'},
      r = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'remove folder'},
      i = {'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'inspect'},
    }
  },
  n = {
    name = '+notes',
    t = {'<Cmd>ZkTags<CR>', 'search by tags'},
    l = {'<Cmd>ZkLinks<CR>', 'current buffer links'},
    b = {'<Cmd>ZkBacklinks<CR>', 'current buffer backlinks'},
    c = {'<Cmd>ZkCd<CR>', 'cd into notes dir'},
    n = {
      name = '+new',
      f = {'<Cmd>ZkNew { dir = "store", template = "fleeting.md" }<CR>', 'new fleeting note'},
      s = {'<Cmd>ZkNew { dir = "store", template = "summary.md" }<CR>', 'new summary note'},
      l = {'<Cmd>ZkNew { dir = "store", template = "literature.md" }<CR>', 'new literature note'},
      e = {'<Cmd>ZkNew { dir = "store", template = "evergreen.md" }<CR>', 'new evergreen note'},
    },
    s = {'<Cmd>ZkNotes { sort = { "modified" } }<CR>', 'search notes'},
  }
}

wk.register(normal_keymap, { prefix = "<leader>" })
wk.register(visual_keymap, { prefix = "<leader>", mode = 'v', silent = false })
