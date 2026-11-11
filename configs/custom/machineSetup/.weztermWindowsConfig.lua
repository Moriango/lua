local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Use this line for Linux/MacOs
-- config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'Main'}


-- Tell Windows to boot WSL and run tmux inside it
config.wsl_domains = {
  {
    -- Gives this connection a name in WezTerm
    name = 'WSL:Ubuntu',
    -- Change this to your specific distro name if you don't use the default
    distribution = 'Ubuntu',
    -- This commands executes INSIDE Linux immediately upon connecting
    default_prog = { 'tmux', 'new-session', '-A', '-s', 'Main' },
  },
}

-- Tells WezTerm to boot into this specific WSL domain by default
config.default_domain = 'WSL:Ubuntu'

config.font_dirs = { wezterm.config_dir .. '/fonts' }
config.font = wezterm.font('JetBrainsMono Nerd Font')

config.automatically_reload_config = true

config.leader = { key = 'w', mods = 'CTRL'}

config.color_scheme = 'LiquidCarbon'

config.font_size = 12.0

config.window_decorations = "NONE"

config.front_end = "OpenGL"
config.window_background_opacity = 0.75
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
}

config.keys = {
  {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'r',
    mods = 'CTRL|ALT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'b',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if overrides.win32_system_backdrop == 'Disable' then
        overrides.win32_system_backdrop = 'Acrylic'
        overrides.window_background_opacity = 0.05
      else
        overrides.win32_system_backdrop = 'Disable'
        overrides.window_background_opacity = 0.75
      end
      window:set_config_overrides(overrides)
    end),
  },
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
  gui:set_inner_size(3440, 1440)
end)

return config
