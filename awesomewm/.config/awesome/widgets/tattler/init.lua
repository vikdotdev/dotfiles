local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local setmetatable = setmetatable
local tattler = { mt = {} }
local data = setmetatable({}, { __mode = "k" })
local widget_state = {}

function tattler.toggle()
  for _, c in ipairs(client.get()) do awful.titlebar.toggle(c) end
  widget_state.enabled = not widget_state.enabled
  tattler.update()
end

function tattler.update()
  client.emit_signal("tattler::update")
end

function tattler.connect(text)
  client.connect_signal("tattler::update", function()
    local value = nil
    if widget_state.enabled then
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

	local enabled_initially = args.enabled_initially or false
  widget_state.enabled = enabled_initially
	local buttons = args.buttons or tattler.default_buttons()
  local text = wibox.widget { buttons = buttons, widget = wibox.widget.textbox }
  local _tattler = wibox.widget.background()
  _tattler:set_widget(text)

  tattler.connect(text)
  tattler.update()

	data[_tattler] = { enabled = enabled_initially }

	_tattler.toggle = tattler.toggle

	return _tattler
end

function tattler.mt:__call(...)
	return tattler.new(...)
end

return setmetatable(tattler, tattler.mt)
