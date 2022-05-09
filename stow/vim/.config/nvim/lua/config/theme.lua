local util = require('../util')

require('github-theme').setup({
  dark_float = true,
  hide_inactive_statusline = false,
  sidebars = {'packer', 'telescope'},
  theme_style = util.get_theme(),
  transparent = true,
  comment_style = "NONE",
  keyword_style = "NONE",
  overrides = function(c)
    return {
      Search = {fg = 'black', bg = '#fbffb5'},
      StatusLine = {fg = c.white, bg = c.blue },
      Function = { fg = c.yellow },
      Constant = { fg = c.green } 
    }
  end
})
