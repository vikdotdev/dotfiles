vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 0,
  files = 0,
}

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))

  -- Old ones below, maybe adapt to new syntax
  -- { key = {"<CR>", "o"},     cb = tree("edit") },
  -- { key = {"="},             cb = tree("cd") },
  -- { key = {"-"},             cb = tree("dir_up") },
  -- { key = {"<C-v>"},         cb = tree("vsplit") },
  -- { key = {"<C-s>"},         cb = tree("split") },
  -- { key = {"<C-t>"},         cb = tree("tabnew") },
  -- { key = {"K"},             cb = tree("prev_sibling") },
  -- { key = {"J"},             cb = tree("next_sibling") },
  -- { key = {"<BS>"},          cb = tree("close_node") },
  -- { key = {"<Tab>"},         cb = tree("preview") },
  -- { key = {"I"},             cb = tree("toggle_ignored") },
  -- { key = {"H"},             cb = tree("toggle_dotfiles") },
  -- { key = {"<C-r>"},         cb = tree("refresh") },
  -- { key = {"a"},             cb = tree("create") },
  -- { key = {"d"},             cb = tree("remove") },
  -- { key = {"r"},             cb = tree("rename") },
  -- { key = {"R"},             cb = tree("full_rename") },
  -- { key = {"c"},             cb = tree("cut") },
  -- { key = {"y"},             cb = tree("copy") },
  -- { key = {"p"},             cb = tree("paste") },
  -- { key = {"C-p"},           cb = tree("prev_git_item") },
  -- { key = {"C-n"},           cb = tree("next_git_item") },
  -- { key = {"q"},             cb = tree("close") },
end

require('nvim-tree').setup({
  actions = {
    use_system_clipboard = true,
    open_file = {
      resize_window = true
    }
  },
  disable_netrw       = true,
  hijack_netrw        = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  hijack_directories   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = false,
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E"
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    adaptive_size = true,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left'
  },
  on_attach = my_on_attach
})
