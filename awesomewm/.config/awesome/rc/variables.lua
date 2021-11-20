local gears = require("gears")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
