local gears = require("gears")
local awful = require("awful")
local naughty = require('naughty')
local hotkeys_popup = require("awful.hotkeys_popup")
local std = require("../../lib.std")
local util = require("../../lib.util")

require("awful.hotkeys_popup.keys")

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({}, "XF86AudioRaiseVolume", function() os.execute("util-volume +5%") end),
  awful.key({}, "XF86AudioLowerVolume", function() os.execute("util-volume -5%") end),
  awful.key({}, "XF86AudioMute", function()
    os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    awful.spawn.easy_async("pactl get-sink-mute @DEFAULT_SINK@", function(out, err)
      local prefix = ''
      if std.trim(string.gsub(out, [[Mute: (.+)]], "%1")) == 'no' then prefix = 'un' end

      if std.trim(err) == '' or err == nil then
        _notification_muted = naughty.notify({
          replaces_id = (_notification_muted and _notification_muted.id or nil),
          preset = naughty.config.presets.normal,
          position = 'top_middle',
          text = "<b>Sound " .. prefix .. "muted</b>",
          timeout = 2
        })
      else
        naughty.notify({
          preset = naughty.config.presets.critical,
          title = 'Error',
          text = tostring(err)
        })
      end
    end)
  end),
  awful.key({}, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end),
  awful.key({}, "XF86AudioNext", function () awful.util.spawn("playerctl next") end),
  awful.key({}, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end),

  awful.key({}, "XF86MonBrightnessUp", function() os.execute("util-backlight -i 1") end),
  awful.key({}, "XF86MonBrightnessDown", function() os.execute("util-backlight -d 1") end),
  awful.key({ modkey, "Control" }, "t", function() util.toggle_titlebars() end),
  awful.key({ modkey }, "s", function () awful.spawn.with_shell("util-rofi-sink") end,
    {description="select audio sink", group="scripts"}),
  awful.key({ modkey }, "space", awful.widget.keyboardlayout().next_layout,
    {description="toggle language layout", group="awesome"}),
  awful.key({ modkey }, "/", hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  awful.key({ modkey }, "g", awful.tag.history.restore,
    {description = "previous tag", group = "tag"}),
  awful.key({ modkey }, "j", function () awful.client.focus.byidx(1) end,
    {description = "focus next window", group = "client"}),
  awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end,
    {description = "focus previous window", group = "client"}),
  -- awful.key({ modkey }, "w", function () mymainmenu:show() end,
  --           {description = "show main menu", group = "awesome"}),

  -- Layout manipulation
  awful.key({ modkey, "Control"   }, "j", function () awful.client.swap.byidx( 1) end,
    {description = "swap with next window", group = "client"}),
  awful.key({ modkey, "Control"   }, "k", function () awful.client.swap.byidx(-1) end,
    {description = "swap with previous window", group = "client"}),
  awful.key({ modkey, "Shift" }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey, "Shift" }, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  awful.key({ modkey }, "\\", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey }, "p", function ()
    -- if awful.widget.keyboardlayout()
    -- awful.widget.keyboardlayout().next_layout
    awful.spawn('rofi -modi drun -i -show drun -p "Run"')
  end,
    {description = "applications", group = "launcher"}),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),
  awful.key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey }, "t", function () awful.layout.inc(1) end,
    {description = "cycle layout", group = "layout"}),
  awful.key({ }, "Print", function () awful.util.spawn("flameshot gui") end),

  -- awful.key({ modkey, "Control" }, "n",
  --           function ()
  --               local c = awful.client.restore()
  --               -- Focus restored client
  --               if c then
  --                 c:emit_signal(
  --                     "request::activate", "key.unminimize", {raise = true}
  --                 )
  --               end
  --           end,
  --           {description = "restore minimized", group = "client"}),

  -- Prompt
  -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
  --           {description = "run prompt", group = "launcher"}),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"})
  -- Menubar
  -- awful.key({ modkey }, "p", function() menubar.show() end,
  --           {description = "show the menubar", group = "launcher"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "tag"}
    )
  )
end

root.keys(globalkeys)
-- }}}
