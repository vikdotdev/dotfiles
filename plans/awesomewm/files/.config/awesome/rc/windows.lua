local beautiful = require("beautiful")
local awful = require("awful")

require("awful.autofocus")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- does not work on initial load?
client.connect_signal("focus", function(c)
  c.opacity=1
end)
client.connect_signal("unfocus", function(c)
  c.opacity=0.95
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("property::class", function(c)
  if c.class == "Spotify" then
    -- awful.util.spawn("notify-send yes")
    -- TODO find a a more maintainable way to do that
    c:move_to_tag(awful.screen.focused().tags[5])
  end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if TATTLER_CONFIG.enabled then
      awful.titlebar.show(c)
    else
      awful.titlebar.hide(c)
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = 2,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"},

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
  }, properties = { titlebars_enabled = TATTLER_CONFIG.enabled }
  },

  { rule = { class = "Firefox" },
    properties = { screen = 1, tag = "8 www" } },
  { rule = { class = "Deluge-gtk" },
    properties = { screen = 1, tag = "2 download" } },
  { rule = { class = "TelegramDesktop" },
    properties = { screen = 1, tag = "9 chat" } },
  { rule = { class = "Thunderbird" },
    properties = { screen = 1, tag = "6 mail" } },
  { rule = { class = "teams-for-linux" },
    properties = { screen = 1, tag = "9 chat" } },
  { rule = { class = "Skype" },
    properties = { screen = 1, tag = "9 chat" } },
  { rule = { class = "Discord" },
    properties = { screen = 1, tag = "9 chat" } },
  { rule = { class = "Oracle VM VirtualBox" },
    properties = { screen = 1, tag = "4 vms" } },
}
-- }}}
