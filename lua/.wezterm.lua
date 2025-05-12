local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.leader = { key = 'w', mods = 'CTRL'}

config.color_scheme = 'LiquidCarbon'

config.font_size = 19.0

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.80
-- config.window_background_opacity = 1

config.macos_window_background_blur = 0

config.enable_tab_bar = true
config.enable_scroll_bar = false
config.use_resize_increments = true

config.window_frame = {
  border_left_width = '0cell',
  border_right_width = '0cell',
  border_bottom_height = '0cell',
  border_top_height = '0cell',
  font_size = 14
}

config.keys = {
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.SendKey { key = 'e', mods = 'CTRL' },
  },
  {
    key = 'f',
    mods = 'CTRL|CMD',
    action = wezterm.action.ToggleFullScreen,
  },
  {
      key = 'w',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'h',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain'},
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain'},
  },
}

return config
