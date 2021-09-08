local path = vim.fn.glob('$HOME/.local/current_theme')

local current_theme = vim.fn.system('cat ' .. path)

if string.match(current_theme, 'light') then
  vim.cmd('colorscheme PaperColor')
  vim.cmd('set bg=light')
else
  -- vim.cmd('colorscheme palenight')
end

vim.g.PaperColor_Theme_Options = {
  theme = {
    default = {
      transparent_background = 1
    }
  }
}
