local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.leader = { key = 'w', mods = 'CTRL'}

config.color_scheme = 'LiquidCarbon'

config.font_size = 13.0

config.window_decorations = "NONE"

config.front_end = "OpenGL"
config.window_background_opacity = 0.05
config.win32_system_backdrop = "Disable"

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
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
      key = 'w',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
      key = 'd',
      mods = 'CTRL|ALT',
      action = wezterm.action.SendString('ssh dev-dsk-toddns-2a-aa042d07.us-west-2.amazon.com\n'),
  },
  {
    key = '1',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 0\n'),
  },
  {
    key = '2',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 1\n'),
  },
  {
    key = '3',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 2\n'),
  },
  {
    key = '4',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 3\n'),
  },
  {
    key = '5',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 4\n'),
  },
  {
    key = '6',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 5\n'),
  },
  {
    key = '7',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 6\n'),
  },
  {
    key = '8',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 7\n'),
  },
  {
    key = '9',
    mods = 'CTRL|ALT',
    action = wezterm.action.SendString('tmux swap-window -d -t 8\n'),
  },
}

config.default_domain = 'WSL:Ubuntu'

-- Screen measured at 3440x1440 (full working area)
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local gui = window:gui_window()
  gui:set_position(-1, 0)
  gui:set_inner_size(3440, 1439)
end)

return config
