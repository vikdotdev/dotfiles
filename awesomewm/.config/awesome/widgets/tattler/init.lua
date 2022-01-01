local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local setmetatable = setmetatable
local tattler = { mt = {} }
local data = setmetatable({}, { __mode = "k" })

function tattler.toggle()
  data.set_enabled(not data.get_enabled())
  for _, c in ipairs(client.get()) do
    if data.get_enabled() then
      awful.titlebar.show(c)
    else
      awful.titlebar.hide(c)
    end
  end
  tattler.update()
end

function tattler.update()
  client.emit_signal("tattler::update")
end

function tattler.connect(text)
  client.connect_signal("tattler::update", function()
    local value = nil
    if data.get_enabled() then
      value = 'Titlebars enabled'
    else
      value = 'Titlebars disabled'
    end
    text:set_text(value)
  end)
end

function tattler.default_buttons()
  return gears.table.join(
    awful.button({ }, 1, tattler.toggle)
  )
end

function tattler.new(args)
	args = args or {}

  data.get_enabled = args.get_enabled
  data.set_enabled = args.set_enabled
	local buttons = args.buttons or tattler.default_buttons()
  local text = wibox.widget { buttons = buttons, widget = wibox.widget.textbox }
  local _tattler = wibox.widget.background()
  _tattler:set_widget(text)

  tattler.connect(text)
  tattler.update()

	data[_tattler] = {}

	_tattler.toggle = tattler.toggle
	_tattler.get_enabled = data.get_enabled
	_tattler.set_enabled = data.set_enabled

	return _tattler
end

function tattler.mt:__call(...)
	return tattler.new(...)
end

return setmetatable(tattler, tattler.mt)
