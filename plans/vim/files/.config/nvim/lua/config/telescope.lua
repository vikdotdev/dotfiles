local actions = require('telescope.actions')

require('telescope').setup({
  pickers = {
    live_grep = {
      mappings = {
        i = { ["<C-r>"] = actions.to_fuzzy_refine },
      },
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    -- prompt_position = "bottom",
    -- prompt_prefix = "> ",
    -- selection_caret = "> ",
    -- entry_prefix = "  ",
    -- initial_mode = "insert",
    -- selection_strategy = "reset",
    -- sorting_strategy = "descending",
    -- layout_strategy = "ivy",
    layout_config = {
      horizontal = {
        width = 0.99,
        height = 0.9
      },
      preview_cutoff = 80,
      preview_width = 0.4
    },
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    -- file_ignore_patterns = {".git/*"},
    -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    -- shorten_path = true,
    -- winblend = 0,
    -- results_width = 0.8,
    -- border = {},
    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    -- color_devicons = true,
    use_less = true,
    -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        d = actions.preview_scrolling_down,
        u = actions.preview_scrolling_up,
        L = actions.move_to_bottom,
        M = actions.move_to_middle,
        H = actions.move_to_top,
        q = actions.send_to_qflist,
      }
    }
  }
})
