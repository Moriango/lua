local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.leader = { key = 'w', mods = 'CTRL'}

config.color_scheme = 'LiquidCarbon'

config.font_size = 12.0

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8

config.macos_window_background_blur = 0

config.enable_tab_bar = false
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
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SendString('ssh dev-dsk-toddns-2a-aa042d07.us-west-2.amazon.com\n'),
  },
  {
    key = '1',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 0\n'),
  },
  {
    key = '2',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 1\n'),
  },
  {
    key = '3',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 2\n'),
  },
  {
    key = '4',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 3\n'),
  },
  {
    key = '5',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 4\n'),
  },
  {
    key = '6',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 5\n'),
  },
  {
    key = '7',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 6\n'),
  },
  {
    key = '8',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 7\n'),
  },
  {
    key = '9',
    mods = 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 8\n'),
  },
  {
    key = 'b',
    mods = 'CMD',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if not overrides.window_background_opacity or overrides.window_background_opacity == 0.8 then
        overrides.window_background_opacity = 1.0
      else
        overrides.window_background_opacity = 0.8
      end
      window:set_config_overrides(overrides)
    end),
  },
}

return config
