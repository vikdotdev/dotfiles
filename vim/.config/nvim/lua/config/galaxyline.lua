local util = require('util')
local condition = require('galaxyline/condition')
local gl = require("galaxyline")

local gls = gl.section
gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local width_above = function(width)
    local squeeze_width = vim.fn.winwidth(0) / 2

    return squeeze_width > width
end

local colors = {
  bg = "#080808",
  fg = "#9e9e9e",
  green = "#8cc85f",
  yellow = "#e3c78a",
  cyan = "#79dac8",
  magenta = "#c678dd",
  blue = "#80a0ff",
  red = "#ff5454",
  orange = "#e65f38",
  purple = "#afafef"
}

local mode_color = {
  n = colors.blue,
  i = colors.green,
  v = colors.magenta,
  [''] = colors.magenta,
  V = colors.magenta,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S=colors.orange,
  [''] = colors.red,
  ic = colors.yellow,
  R = colors.yellow,
  Rv = colors.yellow,
  cv = colors.red,
  ce=colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!']  = colors.red,
  t = colors.green
}

local mode_labels = {
  n = "NORMAL",
  i = "INSERT",
  c = "COMMAND",
  V = "VISUAL",
  [""] = "VISUAL",
  v = "VISUAL",
  R = "REPLACE",
  t = "TERMINAL"
}

gls.left[1] = {
  leftRounded = {
    provider = function()
      return "  "
    end,
    highlight = {colors.fg, colors.bg}
  }
}

gls.left[2] = {
  ViMode = {
    provider = function()
      vim.api.nvim_command('hi GalaxyViMode guibg='..(mode_color[vim.fn.mode()] or colors.red))

      local labels = util.shallow_copy(mode_labels)

      if width_above(60) == false then
        for key, label in pairs(labels) do
          labels[key] = string.sub(label, 1, 1)
        end
      end

      return "  "..(labels[vim.fn.mode()] or "UNKNOWN").." "
    end,
    separator = ' ',
    separator_highlight = {colors.fg, colors.bg},
    highlight = {colors.bg, colors.green, "bold"}
  }
}

gls.left[3] = {
  FileReadOnly = {
    provider = function()
      if vim.bo.filetype == "help" then
        return ""
      end

      if vim.bo.readonly then return "   " end

      return ""
    end,
    condition = condition.buffer_not_empty,
    highlight = {colors.red, colors.bg, "bold"}
  }
}

gls.left[4] = {
  FileName = {
    provider = function()
      if vim.bo.modified then
        vim.api.nvim_command('hi GalaxyFileName guifg='..colors.red)
      end

      if width_above(28) then
        return util.git_path_to_current_buffer()..' '
      end

      return vim.fn.expand('%:t')..' '
    end,
    condition = condition.buffer_not_empty,
    highlight = {colors.green, colors.bg, "bold"}
  }
}

gls.left[5] = {
  BranchLabel = {
    provider = function()
      return "branch:"
    end,
    condition = function()
      local hidden = width_above(50)
      return hidden and condition.check_git_workspace()
    end,
    highlight = {colors.orange, colors.bg, "bold"}
  }
}
gls.left[6] = {
  GitBranch = {
    provider = "GitBranch",
    condition = function()
      local hidden = width_above(40)
      return hidden and condition.check_git_workspace()
    end,
    highlight = {colors.magenta, colors.bg, "bold"}
  }
}

gls.left[7] = {
  Whitespace = {
    provider = function() return " " end,
    highlight = {colors.orange, colors.bg, "bold"}
  }
}

gls.left[8] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = function() return width_above(60) end,
    icon = " +",
    highlight = {colors.green, colors.bg}
  }
}

gls.left[9] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = function() return width_above(60) end,
    icon = " -",
    highlight = {colors.red, colors.bg}
  }
}

gls.left[10] = {
  DiffModified = {
    provider = "DiffModified",
    condition = function() return width_above(60) end,
    icon = " ~",
    highlight = {colors.yellow, colors.bg}
  }
}

gls.right[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local filetypes = { '', 'startify', 'dashboard' }

      for _, filetype in pairs(filetypes) do
        if filetype == vim.bo.filetype then return false end
      end

      return true and width_above(60)
    end,
    icon = 'lsp:',
    separator = '   ',
    separator_highlight = {colors.fg, colors.bg},
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

gls.right[2] = {
  DiagnosticError = {
    condition = function() return width_above(20) end,
    provider = "DiagnosticError",
    icon = "E",
    separator = ' ',
    separator_highlight = {colors.fg, colors.bg},
    highlight = {colors.red, colors.bg, "bold"}
  }
}

gls.right[3] = {
  DiagnosticWarn = {
    condition = function() return width_above(20) end,
    provider = "DiagnosticWarn",
    icon = "W",
    highlight = {colors.orange, colors.bg, "bold"}
  }
}

gls.right[4] = {
  DiagnosticHint = {
    condition = function() return width_above(20) end,
    provider = "DiagnosticHint",
    icon = "H",
    highlight = {colors.fg, colors.bg}
  }
}

gls.right[5] = {
  DiagnosticInfo = {
    condition = function() return width_above(45) end,
    provider = "DiagnosticInfo",
    icon = "I",
    highlight = {colors.fg, colors.bg}
  }
}

gls.right[6] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = function() return width_above(60) end,
    highlight = {colors.magenta, colors.bg, 'bold'}
  }
}

gls.right[7] = {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = {colors.fg, colors.bg},
    highlight = {colors.bg, colors.magenta}
  }
}

gls.right[8] = {
  rightRounded = {
    provider = function() return "  " end,
    highlight = {colors.fg, colors.bg}
  }
}

gls.short_line_left[1] = {
  ShortSeparator = {
    provider = function()
      if width_above(60) then
        return '           '
        --      ___NORMAL__
      end
      return '      '
      --      ___N__
    end,
    highlight = {colors.fg, colors.bg}
  }
}

gls.short_line_left[2] = {
  BufferName = {
    provider = function()
      return util.git_path_to_current_buffer()..' '
    end,
    highlight = {colors.fg, colors.bg}
  }
}

gls.short_line_left[3] = {
  Whitespace = {
    provider = function() return " " end,
    highlight = {colors.fg, colors.bg}
  }
}

gls.short_line_right[7] = gls.right[7]
gls.short_line_right[8] = gls.right[8]

