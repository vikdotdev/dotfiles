local M = {}

local beautiful = require("beautiful")
local gears = require("gears")
local std = require("lib/std")

function M.set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    -- This sets default wallpaper, figure out how to integrate my custom
    -- script into this
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

function M.is_dot_profile(number)
  return tostring(number) == std.trim(os.getenv("DOT_PROFILE") or '1')
end

return M
