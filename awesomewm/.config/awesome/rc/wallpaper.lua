local util = require("lib.util")
local awful = require("awful")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", util.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- TODO This sets default wallpaper, figure out how to integrate my custom
  -- script into this
  -- util.set_wallpaper(s)
end)
