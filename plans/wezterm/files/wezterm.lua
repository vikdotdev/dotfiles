local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.disable_default_key_bindings = true
config.mouse_wheel_scrolls_tabs = false
config.use_fancy_tab_bar = false
config.status_update_interval = 100
config.show_tab_index_in_tab_bar = true

config.font = wezterm.font "Iosevka"
config.color_scheme = 'Dracula'

config.window_frame = {
  font_size = 12.0,
  font = wezterm.font { family = 'Iosevka', weight = 'Bold' },
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = ' ' .. tostring(tab.tab_index + 1) .. ' '

  return wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = title },
    { Attribute = { Intensity = "Normal" } },
  })
end)

wezterm.on('update-status', function(window, pane)
  local mode_name = window:active_key_table()
  if mode_name then
    local color = 'Black'
    if mode_name == 'nav' then color = 'Fuchsia' end
    if mode_name == 'tab' then color = 'Purple' end
    if mode_name == 'window' then color = 'Green' end
    if mode_name == 'resize' then color = 'Blue' end
    if mode_name == 'config' then color = 'Navy' end
    if mode_name == 'copy_mode' then color = 'Tomato' end
    if mode_name == 'search_mode' then color = 'Red' end

    if mode_name == 'search_mode' then mode_name = 'search' end
    if mode_name == 'copy_mode' then mode_name = 'copy' end
    -- TODO helper shortcuts in status?

    mode_name = wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = color } },
      { Text = ' ' .. string.upper(mode_name) .. ' ' },
      'ResetAttributes'
    })
  end

  window:set_right_status(mode_name or '')
end)

config.leader = { key = 'f', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Sends "CTRL-f" to the terminal when pressing CTRL-f, CTRL-f
  {
    key = 'f',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'f', mods = 'CTRL' },
  },

  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateCommandPalette },

  -- Clipboard
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo "Clipboard" },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom "Clipboard" },

  -- Font size
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },

  -- Quick navigation
  { key = 'o', mods = 'LEADER', action = wezterm.action.ActivateLastTab },
  {
    key = 'h', mods = 'LEADER', action = act.Multiple {
      act.ActivateKeyTable {name = 'nav', one_shot = false, prevent_fallback = true},
      act.ActivatePaneDirection 'Left',
    }
  },
  {
    key = 'j', mods = 'LEADER', action = act.Multiple {
      act.ActivateKeyTable {name = 'nav', one_shot = false, prevent_fallback = true},
      act.ActivatePaneDirection 'Down',
    }
  },
  {
    key = 'k', mods = 'LEADER', action = act.Multiple {
      act.ActivateKeyTable {name = 'nav', one_shot = false, prevent_fallback = true},
      act.ActivatePaneDirection 'Up',
    }
  },
  {
    key = 'l', mods = 'LEADER', action = act.Multiple {
      act.ActivateKeyTable {name = 'nav', one_shot = false, prevent_fallback = true},
      act.ActivatePaneDirection 'Right',
    }
  },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
  { key = 'm', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'n', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

  -- Modes
  {
    key = 'd', mods = 'LEADER',
    action = act.ActivateKeyTable {name = 'domain', one_shot = true, prevent_fallback = true },
  },
  { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = '/', mods = 'LEADER', action = act.Search { CaseSensitiveString="" }},
  {
    key = 'w', mods = 'LEADER',
    action = act.ActivateKeyTable {name = 'window', one_shot = false, prevent_fallback = true },
  },
  {
    key = 't', mods = 'LEADER',
    action = act.ActivateKeyTable {name = 'tab', one_shot = false, prevent_fallback = true },

  },
  {
    key = 'q', mods = 'LEADER',
    action = act.ActivateKeyTable {name = 'config', one_shot = true, prevent_fallback = true },
  },
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  config = {
    { key = 'd', action = wezterm.action.ShowDebugOverlay },
    { key = 'r', action = act.ReloadConfiguration },
  },
  nav = {
    { key = 'Escape', action = 'ClearKeyTableStack' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'h', mods = 'SHIFT', action = act.ActivateTabRelativeNoWrap(-1) },
    { key = 'l', mods = 'SHIFT', action = act.ActivateTabRelativeNoWrap(1) },
  },
  window = {
    { key = 'Escape', action = 'ClearKeyTableStack' },
    { key = 'w', mods = 'LEADER', action = 'ClearKeyTableStack' },
    { key = 'v', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
    { key = 's', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
    { key = 'd', action = act.CloseCurrentPane { confirm = false }},
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'r', action = act.ActivateKeyTable {name = 'resize', one_shot = false}},
    { key = 'm', action = act.Multiple { act.TogglePaneZoomState, act.ClearKeyTableStack }},
  },
  resize = {
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'r', action = 'PopKeyTable' },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 4 }},
    { key = 'j', action = act.AdjustPaneSize { 'Down', 2 }},
    { key = 'k', action = act.AdjustPaneSize { 'Up', 2 }},
    { key = 'l', action = act.AdjustPaneSize { 'Right', 4 }},
  },
  tab = {
    { key = 'Escape', action = 'ClearKeyTableStack' },
    { key = 't', mods = 'LEADER', action = 'PopKeyTable' },
    { key = 'd', action = act.CloseCurrentTab { confirm = false }},
    { key = 'n', action = act.SpawnTab 'CurrentPaneDomain'},
    { key = 'h', action = act.ActivateTabRelativeNoWrap(-1) },
    { key = 'l', action = act.ActivateTabRelativeNoWrap(1) },
    { key = 'h', mods = 'SHIFT', action = act.MoveTabRelative(-1) },
    { key = '1', mods = 'CTRL', action = act.MoveTab(0), },
    { key = 'p', action = act.Multiple { act.ShowTabNavigator, act.ClearKeyTableStack }},
    -- Switching tabs with number below with for loop.
  },
}

for i = 1, 8 do
  table.insert(config.key_tables.tab, {
    key = tostring(i),
    action = act.ActivateTab(i - 1),
  })
end

for i = 1, 8 do
  table.insert(config.key_tables.tab, {
    key = tostring(i), mods = 'CTRL', action = act.MoveTab(i - 1),
  })
end

for i = 1, 8 do
  table.insert(config.key_tables.nav, {
    key = tostring(i),
    action = act.ActivateTab(i - 1),
  })
end

config.unix_domains = {
  { name = 'home' },
}

config.default_gui_startup_args = { 'attach', 'home' }

-- TODO: in search mode when pasting it pastes newline and messes with output and screws the search

return config
