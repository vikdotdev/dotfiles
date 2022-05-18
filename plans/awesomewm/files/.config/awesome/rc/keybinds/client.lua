local gears = require("gears")
local awful = require("awful")

clientkeys = gears.table.join(
  awful.key({ modkey }, "f",  awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Shift" }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey }, "d", function (c) c:kill() end,
    {description = "close window", group = "client"}),
  awful.key({ modkey }, "o", function (c) c:move_to_screen() end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey }, "o", function (c) c.ontop = not c.ontop end,
    {description = "toggle keep on top", group = "client"}),
  awful.key({ modkey }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    {description = "minimize", group = "client"}),
  awful.key({ modkey }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "(un)maximize", group = "client"})
)
