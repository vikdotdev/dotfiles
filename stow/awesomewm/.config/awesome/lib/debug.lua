local awful = require("awful")
local gears = require("gears")
local naughty = require('naughty')

local M = {}

function M.pry(value, raw)
  raw = raw or false
  log_path = awful.util.get_cache_dir() .. "/history_output"

  awful.spawn.with_shell("echo =====START=====\n' >> " .. log_path)
  if raw then
    awful.spawn.with_shell([[echo ']] .. value .. [[' >> ]] .. log_path)
  else
    awful.spawn.with_shell([[echo ']] .. gears.debug.dump_return(value) .. [[' >> ]] .. log_path)
  end
  awful.spawn.with_shell("echo '======END======\n' >> " .. log_path)

  naughty.notify({
    preset = naughty.config.presets.normal,
    title = "debug",
    text = 'Pasting result to ' .. log_path
  })
end

return M
