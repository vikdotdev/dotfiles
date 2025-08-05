local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.disable_default_key_bindings = true
config.mouse_wheel_scrolls_tabs = false
config.scrollback_lines = 100000
config.status_update_interval = 500

config.font = wezterm.font "Iosevka"

config.window_frame = {
  font_size = 12.0,
  font = wezterm.font { family = 'Iosevka', weight = 'Bold' },
}

wezterm.on('update-status', function(window, pane)
  local mode_name = window:active_key_table()
  if mode_name then
    local color = 'Black'
    if mode_name == 'xmode' then color = 'Fuchsia' end
    if mode_name == 'cmode' then color = 'Purple' end
    if mode_name == 'config' then color = 'Navy' end
    if mode_name == 'copy_mode' then color = 'Tomato' end
    if mode_name == 'search_mode' then color = 'Red' end

    if mode_name == 'search_mode' then mode_name = 'search' end
    if mode_name == 'copy_mode' then mode_name = 'copy' end
    if mode_name == 'xmode' then mode_name = 'C-x' end
    if mode_name == 'cmode' then mode_name = 'C-c' end

    mode_name = wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = color } },
      { Text = ' ' .. mode_name .. ' ' },
      'ResetAttributes'
    })
  end

  window:set_right_status(mode_name or '')

  workspace = wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = 'Green' } },
    { Text = ' ' .. window:active_workspace() .. ' ' },
    'ResetAttributes'
  })
  window:set_left_status(workspace)
end)

config.leader = { key = ';', timeout_milliseconds = 1000 }
config.keys = {
   { key = ';', mods = 'LEADER', action = wezterm.action.SendKey { key = ';' }},
   {
      key = 'x',
      mods = 'LEADER',
      action = act.ActivateKeyTable {name = 'xmode', one_shot = true, prevent_fallback = true },
   },
   {
      key = 'c',
      mods = 'LEADER',
      action = act.ActivateKeyTable {name = 'cmode', one_shot = true, prevent_fallback = true },
   },

   -- Clipboard
   { key = 'w', mods = 'ALT', action = act.CopyTo "Clipboard" },
   { key = 'y', mods = 'CTRL', action = act.PasteFrom "Clipboard" },

   -- Tab navigation
   { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
   { key = 'Tab', mods = 'SHIFT', action = act.ActivateTabRelative(1) },

   -- Font size
   { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
   { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
   { key = '0', mods = 'CTRL', action = act.ResetFontSize },

   { key = 'o', mods = 'ALT', action = act.ActivatePaneDirection('Next') },
}

config.key_tables = {
   xmode = {
      { key = 'g', mods = "CTRL", action = 'ClearKeyTableStack' },
      { key = '3', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
      { key = '2', action = act.SplitVertical { domain = 'CurrentPaneDomain' }},
      { key = 'm', action = act.TogglePaneZoomState },
      { key = 't', action = act.ActivateKeyTable {name = 'tab', one_shot = true, prevent_fallback = true }},
      { key = 'p', action = wezterm.action.ActivateCommandPalette },
      { key = 'c', action = act.ActivateKeyTable {name = 'config', one_shot = true, prevent_fallback = true }},
   },
   cmode = {
      { key = 'g', mods = "CTRL", action = 'ClearKeyTableStack' },
      { key = 'c', action = act.ActivateCopyMode },
      -- TODO add C-s and C-r for search mode properly
      { key = 's', mods = 'CTRL', action = act.Search { CaseSensitiveString="Regex" }},
   },
   config = {
      { key = 'g', mods = "CTRL", action = 'ClearKeyTableStack' },
      { key = 'd', action = wezterm.action.ShowDebugOverlay },
      { key = 'r', action = act.ReloadConfiguration },
   },
   tab = {
      { key = 'g', mods = "CTRL", action = 'ClearKeyTableStack' },
      { key = '0', action = act.CloseCurrentTab { confirm = true }},
      { key = '2', action = act.SpawnTab 'CurrentPaneDomain'},
   }
}

-- TODO: in search mode when pasting it pastes newline and messes with output and screws the search

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Dracula'
  else
    return 'Builtin Solarized Light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
