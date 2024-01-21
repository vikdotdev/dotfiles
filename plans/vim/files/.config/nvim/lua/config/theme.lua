local function apply_colors(config, theme)
  local colors = config.colors[theme]

  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.magenta
  vim.g.terminal_color_5 = colors.blue
  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_7 = colors.white
  vim.g.terminal_color_8 = colors.bright_black
  vim.g.terminal_color_9 = colors.bright_red
  vim.g.terminal_color_10 = colors.bright_green
  vim.g.terminal_color_11 = colors.bright_yellow
  vim.g.terminal_color_12 = colors.bright_blue
  vim.g.terminal_color_13 = colors.bright_magenta
  vim.g.terminal_color_14 = colors.bright_cyan
  vim.g.terminal_color_15 = colors.bright_white
  vim.g.terminal_color_background = colors.bg
  vim.g.terminal_color_foreground = colors.fg
end

local function highlight_groups(config, theme)
  local colors = config.colors[theme]
  local endOfBuffer = { fg = colors.gray_2 or colors.bg, }

  return {
    Normal = { fg = colors.fg, bg = nil, },
    NormalFloat = { fg = colors.fg, bg = colors.gray_3, },
    Comment = { fg = colors.black, },
    Constant = { fg = colors.bright_red, },
    String = { fg = colors.bright_green, },
    Character = { fg = colors.green, },
    Number = { fg = colors.bright_yellow, },
    Boolean = { fg = colors.bright_blue, },
    Float = { fg = colors.bright_yellow, },
    FloatBorder = { fg = colors.white, },
    Operator = { fg = colors.magenta, },
    Keyword = { fg = colors.bright_red, },
    Keywords = { fg = colors.bright_red, },
    Identifier = { fg = colors.magenta, },
    Function = { fg = colors.yellow, },
    Statement = { fg = colors.magenta, },
    Conditional = { fg = colors.bright_red, },
    Repeat = { fg = colors.bright_red, },
    Label = { fg = colors.cyan, },
    Exception = { fg = colors.magenta, },
    PreProc = { fg = colors.yellow, },
    Include = { fg = colors.magenta, },
    Define = { fg = colors.magenta, },
    Title = { fg = colors.cyan, },
    Macro = { fg = colors.magenta, },
    PreCondit = { fg = colors.cyan, },
    Type = { fg = colors.cyan, },
    StorageClass = { fg = colors.red, },
    Structure = { fg = colors.yellow, },
    TypeDef = { fg = colors.yellow, },
    Special = { fg = colors.bright_red },
    SpecialComment = { fg = colors.bright_black, },
    Error = { fg = colors.bright_red, },
    Todo = { fg = colors.magenta, bold = true, italic = true, },
    Underlined = { fg = colors.cyan, underline = true, },

    Cursor = { reverse = true, },
    CursorLineNr = { fg = colors.fg, bold = true, },

    SignColumn = { bg = nil and colors.bg, },

    Conceal = { fg = colors.bright_black, },
    CursorColumn = { bg = colors.gray_2, },
    CursorLine = { bg = colors.gray_2, },
    ColorColumn = { bg = colors.gray_2, },

    StatusLine = { fg = colors.white, bg = colors.gray_5, },
    StatusLineNC = { fg = colors.gray_6, bg = colors.gray_2 },
    StatusLineTerm = { fg = colors.white, bg = colors.black, },
    StatusLineTermNC = { fg = colors.bright_black, },

    Directory = { fg = colors.bright_cyan, },
    DiffAdd = { fg = colors.bg, bg = colors.bright_green, },
    DiffChange = { fg = colors.cyan, },
    DiffDelete = { fg = colors.red, },
    DiffText = { fg = colors.bright_black, },

    ErrorMsg = { fg = colors.red, },
    VertSplit = { fg = colors.black, },
    Folded = { fg = colors.bright_black, },
    FoldColumn = {},
    Search = { fg = colors.black, bg = colors.yellow, },
    IncSearch = { fg = colors.black, bg = colors.bright_yellow, },
    LineNr = { fg = colors.bright_black, },
    MatchParen = { fg = colors.fg, underline = true, },
    NonText = { fg = colors.black, },
    Pmenu = { fg = colors.white, bg = colors.black, },
    PmenuSel = { fg = colors.white, bg = colors.gray_3, },
    PmenuSbar = { bg = colors.bg, },
    PmenuThumb = { bg = colors.black, },

    Question = { fg = colors.magenta, },
    QuickFixLine = { bg = colors.gray_4, },
    SpecialKey = { fg = colors.bright_yellow, },

    SpellBad = { fg = colors.bright_red, underline = true, },
    SpellCap = { fg = colors.yellow, },
    SpellLocal = { fg = colors.yellow, },
    SpellRare = { fg = colors.yellow, },

    TabLine = { fg = colors.bright_black, },
    TabLineSel = { fg = colors.white, },
    TabLineFill = { bg = colors.bg, },
    Terminal = { fg = colors.white, bg = colors.black, },
    Visual = { bg = colors.gray_3, },
    VisualNOS = { fg = colors.gray_2, },
    WarningMsg = { fg = colors.yellow, },
    WildMenu = { fg = colors.black, bg = colors.white, },

    -- TODO maybe methods green? strings yellow
    -- pink == literals, something built in
    -- red = instance variable / constant (or something sort of constant (sym, bool)) / type
    -- magenta = local variable
    -- cyan = something callable, function, method, proc
    -- punctuation = white
    --
    ['@error'] = { fg = colors.bright_red, },
    ['@punctuation.delimiter'] = { fg = colors.fg, },
    ['@punctuation.bracket'] = { fg = colors.fg, },
    ['@punctuation.special'] = { fg = colors.white, },

    ['@constant'] = { fg = colors.red, },
    ['@constant.builtin'] = { fg = colors.bright_red, },
    ['@symbol'] = { fg = colors.red, },

    -- TODO where is this used?
    -- ['@constant.macro'] = { fg = colors.cyan, },
    -- ['@string.regex'] = { fg = colors.red, },
    ['@string'] = { fg = colors.bright_green, },
    ['@string.escape'] = { fg = colors.red, },
    ['@character'] = { fg = colors.bright_green, },
    ['@number'] = { fg = colors.bright_yellow },
    ['@boolean'] = { fg = colors.red },
    ['@float'] = { fg = colors.bright_yellow },
    -- TODO where is this used?
    -- ['@annotation'] = { fg = colors.yellow, },
    -- ['@attribute'] = { fg = colors.red, },
    ['@namespace'] = { fg = colors.bright_red, },
    --
    -- TODO where is this used?
    -- ['@function.builtin'] = { fg = colors.cyan, },
    ['@function'] = { fg = colors.bright_blue, },
    -- TODO where is this used?
    -- ['@function.macro'] = { fg = colors.green, },
    -- ['@parameter'] = { fg = colors.white, },
    -- ['@parameter.reference'] = { fg = colors.white, },
    ['@method'] = { fg = colors.bright_blue, },
    ['@field'] = { fg = colors.bright_blue, },
    -- TODO where is this used?
    -- ['@property'] = { fg = colors.magenta, },
    ['@constructor'] = { fg = colors.bright_cyan, },
    --
    ['@conditional'] = { fg = colors.bright_red, },
    -- TODO where is this used?
    -- ['@repeat'] = { fg = colors.pink, },
    ['@label'] = { fg = colors.red, },
    --
    ['@keyword'] = { fg = colors.bright_red, },
    -- TODO where is this used?
    -- ['@keyword.function'] = { fg = colors.cyan, },
    -- ['@keyword.function.ruby'] = { fg = colors.bright_red, },
    ['@keyword.operator'] = { fg = colors.bright_blue, },
    ['@operator'] = { fg = colors.bright_blue, },
    ['@exception'] = { fg = colors.bright_red, },
    ['@type'] = { fg = colors.red, },
    -- TODO where is this used?
    -- ['@type.builtin'] = { fg = colors.cyan, italic = true, },
    -- ['@type.qualifier'] = { fg = colors.pink, },
    -- ['@structure'] = { fg = colors.magenta, },
    ['@include'] = { fg = colors.bright_red, },
    --
    ['@variable'] = { fg = colors.magenta, },
    -- ['@variable.builtin'] = { fg = colors.magenta, },

    -- ['@text'] = { fg = colors.white, },
    ['@text.strong'] = { fg = colors.white, bold = true, }, -- bold
    ['@text.emphasis'] = { fg = colors.white, italic = true, }, -- italic
    ['@text.underline'] = { fg = colors.white, underline = true },
    ['@text.minus_metadata'] = { fg = colors.bright_red },
    -- ['@text.title'] = { fg = colors.pink, bold = true, }, -- title
    ['@text.literal'] = { fg = colors.cyan, }, -- inline code
    ['@text.uri'] = { fg = colors.cyan, }, -- urls
    ['@text.reference'] = { fg = colors.bright_magenta, underline = false },
    ['@text.quote'] = { fg = colors.yellow, },
    --
    -- ['@tag'] = { fg = colors.cyan, },
    -- ['@tag.attribute'] = { fg = colors.green, },
    -- ['@tag.delimiter'] = { fg = colors.cyan, },
    --
    -- -- Semantic
    -- ['@class'] = { fg = colors.cyan },
    -- ['@struct'] = { fg = colors.cyan },
    -- ['@enum'] = { fg = colors.cyan },
    -- ['@enumMember'] = { fg = colors.magenta },
    -- ['@event'] = { fg = colors.cyan },
    -- ['@interface'] = { fg = colors.cyan },
    -- ['@modifier'] = { fg = colors.cyan },
    -- ['@regexp'] = { fg = colors.yellow },
    -- ['@typeParameter'] = { fg = colors.cyan },
    -- ['@decorator'] = { fg = colors.cyan },
    --
    -- -- LSP Semantic (0.9+)
    -- ['@lsp.type.class'] = { fg = colors.cyan },
    -- ['@lsp.type.enum'] = { fg = colors.cyan },
    -- ['@lsp.type.decorator'] = { fg = colors.green },
    -- ['@lsp.type.enumMember'] = { fg = colors.magenta },
    -- ['@lsp.type.function'] = { fg = colors.green, },
    -- ['@lsp.type.interface'] = { fg = colors.cyan },
    -- ['@lsp.type.macro'] = { fg = colors.cyan },
    -- ['@lsp.type.method'] = { fg = colors.green, },
    -- ['@lsp.type.namespace'] = { fg = colors.yellow, },
    -- ['@lsp.type.parameter'] = { fg = colors.yellow, },
    -- ['@lsp.type.property'] = { fg = colors.magenta, },
    -- ['@lsp.type.struct'] = { fg = colors.cyan },
    -- ['@lsp.type.type'] = { fg = colors.bright_cyan, },
    -- ['@lsp.type.variable'] = { fg = colors.fg, },

    -- Git Signs
    GitSignsAdd = { fg = colors.bright_green, },
    GitSignsChange = { fg = colors.cyan, },
    GitSignsDelete = { fg = colors.bright_red, },
    GitSignsAddLn = { fg = colors.black, bg = colors.bright_green, },
    GitSignsChangeLn = { fg = colors.black, bg = colors.cyan, },
    GitSignsDeleteLn = { fg = colors.black, bg = colors.bright_red, },
    GitSignsCurrentLineBlame = { fg = colors.white, },

    -- NvimTree
    NvimTreeNormal = { fg = colors.fg, bg = nil, },
    NvimTreeVertSplit = { fg = colors.bg, bg = colors.bg, },
    NvimTreeRootFolder = { fg = colors.fg, bold = true, },
    NvimTreeGitDirty = { fg = colors.cyan, },
    NvimTreeGitNew = { fg = colors.bright_green, },
    NvimTreeImageFile = { fg = colors.bright_red, },
    NvimTreeFolderIcon = { fg = colors.magenta, },
    NvimTreeIndentMarker = { fg = colors.gray_5, },
    NvimTreeEmptyFolderName = { fg = colors.gray_5, },
    NvimTreeFolderName = { fg = colors.fg, },
    NvimTreeSpecialFile = { fg = colors.magenta, },
    NvimTreeOpenedFolderName = { fg = colors.fg, bold = true },
    NvimTreeCursorLine = { bg = colors.gray_2, },
    -- NOTE: this might break someday
    NvimTreeWindowPicker = { fg = colors.fg, bg = colors.gray_8, bold = true },
    NvimTreeEndOfBuffer = endOfBuffer,

    DiagnosticError = { fg = colors.red, },
    DiagnosticWarn = { fg = colors.yellow, },
    DiagnosticInfo = { fg = colors.cyan, },
    DiagnosticHint = { fg = colors.cyan, },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red, },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow, },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan, },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan, },
    DiagnosticSignError = { fg = colors.red, },
    DiagnosticSignWarn = { fg = colors.yellow, },
    DiagnosticSignInfo = { fg = colors.cyan, },
    DiagnosticSignHint = { fg = colors.cyan, },
    DiagnosticFloatingError = { fg = colors.red, },
    DiagnosticFloatingWarn = { fg = colors.yellow, },
    DiagnosticFloatingInfo = { fg = colors.cyan, },
    DiagnosticFloatingHint = { fg = colors.cyan, },
    DiagnosticVirtualTextError = { fg = colors.red, },
    DiagnosticVirtualTextWarn = { fg = colors.yellow, },
    DiagnosticVirtualTextInfo = { fg = colors.cyan, },
    DiagnosticVirtualTextHint = { fg = colors.cyan, },

    LspDiagnosticsDefaultError = { fg = colors.red, },
    LspDiagnosticsDefaultWarning = { fg = colors.yellow, },
    LspDiagnosticsDefaultInformation = { fg = colors.cyan, },
    LspDiagnosticsDefaultHint = { fg = colors.cyan, },
    LspDiagnosticsUnderlineError = { fg = colors.red, undercurl = true, },
    LspDiagnosticsUnderlineWarning = { fg = colors.yellow, undercurl = true, },
    LspDiagnosticsUnderlineInformation = { fg = colors.cyan, undercurl = true, },
    LspDiagnosticsUnderlineHint = { fg = colors.cyan, undercurl = true, },
    LspReferenceText = { fg = colors.cyan, },
    LspReferenceRead = { fg = colors.cyan, },
    LspReferenceWrite = { fg = colors.cyan, },
    LspCodeLens = { fg = colors.cyan, },

    -- Cmp
    CmpItemKind = { link = "Pmenu" },
    CmpItemAbbr = { link = "Pmenu" },
    CmpItemKindMethod = { link = "@method" },
    -- CmpItemKindText = { link = "@text" },
    CmpItemKindFunction = { link = "@function" },
    CmpItemKindConstructor = { link = "@type" },
    CmpItemKindVariable = { link = "@variable" },
    CmpItemKindClass = { link = "@type" },
    CmpItemKindInterface = { link = "@type" },
    CmpItemKindModule = { link = "@namespace" },
    -- CmpItemKindProperty = { link = "@property" },
    CmpItemKindOperator = { link = "@operator" },
    -- CmpItemKindReference = { link = "@parameter.reference" },
    CmpItemKindUnit = { link = "@field" },
    CmpItemKindValue = { link = "@field" },
    CmpItemKindField = { link = "@field" },
    CmpItemKindEnum = { link = "@field" },
    CmpItemKindKeyword = { link = "@keyword" },
    CmpItemKindSnippet = { link = "@text" },
    -- CmpItemKindColor = { link = "DevIconCss" },
    -- CmpItemKindFile = { link = "TSURI" },
    -- CmpItemKindFolder = { link = "TSURI" },
    CmpItemKindEvent = { link = "@constant" },
    CmpItemKindEnumMember = { link = "@field" },
    CmpItemKindConstant = { link = "@constant" },
    CmpItemKindStruct = { link = "@structure" },
    CmpItemKindTypeParameter = { link = "@parameter" },

    -- Packer
    packerSuccess = { fg = colors.bright_green },
    packerStatusSuccess = { fg = colors.bright_green },
  }
end

local function apply_highlight_groups(config, theme)
  local groups = highlight_groups(config, theme)
  for group, setting in pairs(groups) do
    vim.api.nvim_set_hl(0, group, setting)
  end
end

local function apply(theme)
  theme = theme or 'dark'
  local config = {
    colors = require("config/palette"),
    theme = theme
  }

  if vim.g.colors_name then vim.cmd("hi clear") end
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.background = nil
  vim.o.termguicolors = true

  vim.g.colors_name = 'vikdotdev_' .. theme

  apply_colors(config, theme)
  apply_highlight_groups(config, theme)
end

apply()

return {
  apply_theme = apply
}
