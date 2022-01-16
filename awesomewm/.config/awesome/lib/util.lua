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

function M.is_desktop()
  return M.hostname() == std.trim(os.getenv("HOSTNAME_DESKTOP"))
end

function M.is_laptop()
  return M.hostname() == std.trim(os.getenv("HOSTNAME_LAPTOP"))
end

function M.hostname()
    local f = io.popen ("/bin/hostname")
    local hostname = f:read("*a") or ""
    f:close()
    return std.trim(hostname)
end

return M
