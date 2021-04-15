vim.g.iron_map_defaults = false

local iron = require('iron')

iron.core.add_repl_definitions {
  ruby = {
    pry = {
      command = { 'pry' }
    }
  },
}

iron.core.set_config {
  preferred = {
    lua = 'lua', -- TODO: user luajit instead
    ruby = "pry",
  }
}

-- enables automatic resizing
vim.cmd [[autocmd BufLeave * if &buftype == 'terminal' | :set nowfw | endif]]

vim.g.iron_map_defaults = false
vim.g.iron_map_extended = false

return iron

