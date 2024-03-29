-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
require("rc.startup_errors")
require("rc.variables")
require("rc.layouts")
require("rc.menu")
require('rc.bar')
require('rc.keybinds.mouse')
require('rc.keybinds.global')
require('rc.keybinds.client')
require('rc.titlebar')
require('rc.windows')
require('rc.autostart')
