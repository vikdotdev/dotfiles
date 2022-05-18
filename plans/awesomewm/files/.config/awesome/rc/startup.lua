local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local util = require("lib.util")

-- TODO move those out
local commands = {
  'util-wallpaper',
  'sys-compton-restart',
}

for _, command in ipairs(commands) do
  awful.spawn.with_shell(command)
end
