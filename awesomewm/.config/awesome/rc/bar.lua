local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require('naughty')
local std = require("../lib.std")

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", {raise = true})
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)


local internet_connection_container = wibox.container.background()
internet_connection_container:set_fg("#000000")

local internet = awful.widget.watch([[bash -c "ping -i 0.5 -w 10 -c 10 8.8.8.8 | tail -n 2 | head -n 1"]], 5, function(widget, stdout)
  local raw_value = stdout:match([[(%d+)%% packet loss]])
  if raw_value == nil then raw_value = '100' end

  local value = tonumber(std.trim(raw_value))
  local text = ' ' .. value .. '% lost '

  if value > 0 then
    internet_connection_container:set_bg("#ff543d")

    local notification_text = 'Internet unstable'
    if value == 100 then notification_text = 'No internet connection' end

    _INTERNET_NOTIFICATION = naughty.notify({
      replaces_id = (_INTERNET_NOTIFICATION and _INTERNET_NOTIFICATION.id or nil),
      position = 'top_middle',
      text     = notification_text,
      timeout  = 5,
    })
  else
    internet_connection_container:set_bg("#80fa73")
  end

  widget:set_text(text)
end)

internet_connection_container:set_widget(internet)

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1 other", "2 torrent", "3 files", "4", "5 music", "6 mail", "7 code", "8 www", "9 chat" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      internet_connection_container,
      layout = wibox.layout.fixed.horizontal,
      awful.widget.keyboardlayout(),
      wibox.widget.systray(),
      wibox.widget.textclock(),
      s.mylayoutbox,
    },
  }
end)
