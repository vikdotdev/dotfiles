-- local util = require('util')
-- local condition = require('galaxyline/condition')
-- local gl = require("galaxyline")
--
-- local gls = gl.section
-- gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines
--
-- local width_above = function(width)
--     local squeeze_width = vim.fn.winwidth(0) / 2
--
--     return squeeze_width > width
-- end
--
-- local colors = {
--   bg = "#080808",
--   fg = "#9e9e9e",
--   green = "#8cc85f",
--   yellow = "#e3c78a",
--   cyan = "#79dac8",
--   magenta = "#c678dd",
--   blue = "#80a0ff",
--   red = "#ff5454",
--   orange = "#e65f38",
--   purple = "#afafef"
-- }
--
-- local mode_color = {
--   n = colors.blue,
--   i = colors.green,
--   v = colors.magenta,
--   [''] = colors.magenta,
--   V = colors.magenta,
--   c = colors.magenta,
--   no = colors.red,
--   s = colors.orange,
--   S=colors.orange,
--   [''] = colors.red,
--   ic = colors.yellow,
--   R = colors.yellow,
--   Rv = colors.yellow,
--   cv = colors.red,
--   ce=colors.red,
--   r = colors.cyan,
--   rm = colors.cyan,
--   ['r?'] = colors.cyan,
--   ['!']  = colors.red,
--   t = colors.green
-- }
--
-- local mode_labels = {
--   n = "NORMAL",
--   i = "INSERT",
--   c = "COMMAND",
--   V = "VISUAL",
--   [""] = "VISUAL",
--   v = "VISUAL",
--   R = "REPLACE",
--   t = "TERMINAL"
-- }
--
-- gls.left[1] = {
--   leftRounded = {
--     provider = function()
--       return "  "
--     end,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.left[2] = {
--   ViMode = {
--     provider = function()
--       vim.api.nvim_command('hi GalaxyViMode guibg='..(mode_color[vim.fn.mode()] or colors.red))
--
--       local labels = util.shallow_copy(mode_labels)
--
--       if width_above(60) == false then
--         for key, label in pairs(labels) do
--           labels[key] = string.sub(label, 1, 1)
--         end
--       end
--
--       return "  "..(labels[vim.fn.mode()] or "UNKNOWN").." "
--     end,
--     separator = ' ',
--     separator_highlight = {colors.fg, colors.bg},
--     highlight = {colors.bg, colors.green, "bold"}
--   }
-- }
--
-- gls.left[3] = {
--   FileReadOnly = {
--     provider = function()
--       if vim.bo.filetype == "help" then
--         return ""
--       end
--
--       if vim.bo.readonly then return "   " end
--
--       return ""
--     end,
--     condition = condition.buffer_not_empty,
--     highlight = {colors.red, colors.bg, "bold"}
--   }
-- }
--
-- gls.left[4] = {
--   FileName = {
--     provider = function()
--       if vim.bo.modified then
--         vim.api.nvim_command('hi GalaxyFileName guifg='..colors.red)
--       end
--
--       if width_above(28) then
--         return util.git_path_to_current_buffer()..' '
--       end
--
--       return vim.fn.expand('%:t')..' '
--     end,
--     condition = condition.buffer_not_empty,
--     highlight = {colors.green, colors.bg, "bold"}
--   }
-- }
--
-- gls.left[5] = {
--   BranchLabel = {
--     provider = function()
--       return "branch:"
--     end,
--     condition = function()
--       local hidden = width_above(50)
--       return hidden and condition.check_git_workspace()
--     end,
--     highlight = {colors.orange, colors.bg, "bold"}
--   }
-- }
-- gls.left[6] = {
--   GitBranch = {
--     provider = "GitBranch",
--     condition = function()
--       local hidden = width_above(40)
--       return hidden and condition.check_git_workspace()
--     end,
--     highlight = {colors.magenta, colors.bg, "bold"}
--   }
-- }
--
-- gls.left[7] = {
--   Whitespace = {
--     provider = function() return " " end,
--     highlight = {colors.orange, colors.bg, "bold"}
--   }
-- }
--
-- gls.left[8] = {
--   DiffAdd = {
--     provider = "DiffAdd",
--     condition = function() return width_above(60) end,
--     icon = " +",
--     highlight = {colors.green, colors.bg}
--   }
-- }
--
-- gls.left[9] = {
--   DiffRemove = {
--     provider = "DiffRemove",
--     condition = function() return width_above(60) end,
--     icon = " -",
--     highlight = {colors.red, colors.bg}
--   }
-- }
--
-- gls.left[10] = {
--   DiffModified = {
--     provider = "DiffModified",
--     condition = function() return width_above(60) end,
--     icon = " ~",
--     highlight = {colors.yellow, colors.bg}
--   }
-- }
--
-- gls.right[1] = {
--   ShowLspClient = {
--     provider = 'GetLspClient',
--     condition = function ()
--       local filetypes = { '', 'startify', 'dashboard' }
--
--       for _, filetype in pairs(filetypes) do
--         if filetype == vim.bo.filetype then return false end
--       end
--
--       return true and width_above(60)
--     end,
--     icon = 'lsp:',
--     separator = '   ',
--     separator_highlight = {colors.fg, colors.bg},
--     highlight = {colors.cyan,colors.bg,'bold'}
--   }
-- }
--
-- gls.right[2] = {
--   DiagnosticError = {
--     condition = function() return width_above(20) end,
--     provider = "DiagnosticError",
--     icon = "E",
--     separator = ' ',
--     separator_highlight = {colors.fg, colors.bg},
--     highlight = {colors.red, colors.bg, "bold"}
--   }
-- }
--
-- gls.right[3] = {
--   DiagnosticWarn = {
--     condition = function() return width_above(20) end,
--     provider = "DiagnosticWarn",
--     icon = "W",
--     highlight = {colors.orange, colors.bg, "bold"}
--   }
-- }
--
-- gls.right[4] = {
--   DiagnosticHint = {
--     condition = function() return width_above(20) end,
--     provider = "DiagnosticHint",
--     icon = "H",
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.right[5] = {
--   DiagnosticInfo = {
--     condition = function() return width_above(45) end,
--     provider = "DiagnosticInfo",
--     icon = "I",
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.right[6] = {
--   FileEncode = {
--     provider = 'FileEncode',
--     condition = function() return width_above(60) end,
--     highlight = {colors.magenta, colors.bg, 'bold'}
--   }
-- }
--
-- gls.right[7] = {
--   LineInfo = {
--     provider = 'LineColumn',
--     highlight = { colors.fg, colors.bg },
--     condition = function() return width_above(45) end,
--     separator = ' ',
--     separator_highlight = { colors.bg, colors.bg },
--   }
-- }
--
-- gls.right[8] = {
--   PerCent = {
--     provider = "LinePercent",
--     separator = " ",
--     separator_highlight = {colors.fg, colors.bg},
--     highlight = {colors.bg, colors.magenta}
--   }
-- }
--
-- gls.right[9] = {
--   rightRounded = {
--     provider = function() return "  " end,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.short_line_left[1] = {
--   ShortSeparator = {
--     provider = function()
--       if width_above(60) then
--         return '           '
--         --      ___NORMAL__
--       end
--       return '      '
--       --      ___N__
--     end,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.short_line_left[2] = {
--   BufferName = {
--     provider = function()
--       return util.git_path_to_current_buffer()..' '
--     end,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.short_line_left[3] = {
--   Whitespace = {
--     provider = function() return " " end,
--     highlight = {colors.fg, colors.bg}
--   }
-- }
--
-- gls.short_line_right[7] = gls.right[7]
-- gls.short_line_right[8] = gls.right[8]

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    red = utils.get_highlight("DiagnosticError").fg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("DiagnosticWarn").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag = {
        warn = utils.get_highlight("DiagnosticWarn").fg,
        error = utils.get_highlight("DiagnosticError").fg,
        hint = utils.get_highlight("DiagnosticHint").fg,
        info = utils.get_highlight("DiagnosticInfo").fg,
    },
    git = {
        -- del = utils.get_highlight("diffDeleted").fg,
        -- add = utils.get_highlight("diffAdded").fg,
        -- change = utils.get_highlight("diffChanged").fg,
    },
}

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if yow like it vvvvverbose!
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no^V"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["^V"] = "^V",
            ["^Vs"] = "^V",
            s = "S",
            S = "S_",
            ["^S"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = colors.red ,
            i = colors.green,
            v = colors.cyan,
            V =  colors.cyan,
            ["^V"] =  colors.cyan,
            c =  colors.orange,
            s =  colors.purple,
            S =  colors.purple,
            ["^S"] =  colors.purple,
            R =  colors.orange,
            r =  colors.orange,
            ["!"] =  colors.red,
            t =  colors.red,
        }
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
        return " %2("..self.mode_names[self.mode].."%)"
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], style = "bold", }
    end,
}


local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        provider = function() if vim.bo.modified then return "[+]" end end,
        hl = { fg = colors.green }

    }, {
        provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return "" end end,
        hl = { fg = colors.orange }
    }
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = colors.cyan, style = 'bold', force=true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    unpack(FileFlags), -- A small optimisation, since their parent does nothing
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, style = 'bold' },
}
local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}
local FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and fmt:upper()
    end
}
local FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize <= 0 then
            return "0"..suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
    end
}
local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_gett_name(0))
        return (ftime > 0) and os.date("%c", ftime)
    end
}
-- I take no credits for this! :lion:
local ScrollBar ={
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
        return string.rep(self.sbar[i], 2)
    end
}

local LSPActive = {
    condition = conditions.lsp_attached,

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider  = function()
        local names = {}
        for i, server in ipairs(vim.lsp.buf_get_clients(0)) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = colors.green, style = "bold" },
}
local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = "E",
        warn_icon = "W",
        info_icon = "I",
        hint_icon = "H",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    {
        provider = "![",
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = colors.diag.error },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = colors.diag.warn },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = colors.diag.info },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = colors.diag.hint },
    },
    {
        provider = "]",
    },
}
local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = colors.orange },


    {   -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = {style = 'bold'}
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = colors.git.add },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = colors.git.del },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { fg = colors.git.change },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
}
local WorkDir = {
    provider = function()
        local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
        end
        local trail = cwd:sub(-1) == '/' and '' or "/"
        return icon .. cwd  .. trail
    end,
    hl = { fg = colors.blue, style = "bold" },
}
local Align = { provider = "%=" }
local Space = { provider = " " }

-- ViMode = utils.surround({ "", "" }, colors.bright_bg, { ViMode, Snippets })

local DefaultStatusline = {
    ViMode, Space, FileName, Space, Git, Space, Diagnostics, Align,
    Align,
    LSPActive, Space, Space, Space, FileType, Space, ScrollBar
}

require('heirline').setup(DefaultStatusline)
