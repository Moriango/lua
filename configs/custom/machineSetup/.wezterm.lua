local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Detect operating system
local is_windows = string.find(wezterm.target_triple, 'windows') ~= nil

-- ============================================================================
-- System-specific configuration
-- ============================================================================

if is_windows then
  -- Windows with WSL
  config.wsl_domains = {
    {
      name = 'WSL:Ubuntu',
      distribution = 'Ubuntu',
    },
  }
  config.default_domain = 'WSL:Ubuntu'
  config.front_end = 'OpenGL'
  config.window_background_opacity = 0.75
  config.win32_system_backdrop = 'Disable'
  -- config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'Main' }
end

-- ============================================================================
-- Common configuration
-- ============================================================================

config.automatically_reload_config = true

config.font_size = 12.0
config.font_dirs = { wezterm.config_dir .. '/fonts' }
config.font = wezterm.font('JetBrainsMono Nerd Font')

config.leader = { key = 'w', mods = 'CTRL' }

config.color_scheme = 'LiquidCarbon'

config.window_decorations = 'NONE'

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

-- ============================================================================
-- Keybindings
-- ============================================================================

config.keys = {
  -- Common keybindings
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
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('ssh dev-dsk-toddns-2a-aa042d07.us-west-2.amazon.com\n'),
  },
  {
    key = '1',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 0\n'),
  },
  {
    key = '2',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 1\n'),
  },
  {
    key = '3',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 2\n'),
  },
  {
    key = '4',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 3\n'),
  },
  {
    key = '5',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 4\n'),
  },
  {
    key = '6',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 5\n'),
  },
  {
    key = '7',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 6\n'),
  },
  {
    key = '8',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 7\n'),
  },
  {
    key = '9',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action.SendString('tmux swap-window -d -t 8\n'),
  },
  {
    key = 'b',
    mods = is_windows and 'CTRL|ALT' or 'CMD',
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if is_windows then
        -- Windows: toggle backdrop and opacity
        if overrides.win32_system_backdrop == 'Disable' then
          overrides.win32_system_backdrop = 'Acrylic'
          overrides.window_background_opacity = 0.05
        else
          overrides.win32_system_backdrop = 'Disable'
          overrides.window_background_opacity = 0.75
        end
      else
        -- Linux/macOS: toggle opacity
        if not overrides.window_background_opacity or overrides.window_background_opacity == 0.8 then
          overrides.window_background_opacity = 1.0
        else
          overrides.window_background_opacity = 0.8
        end
      end
      window:set_config_overrides(overrides)
    end),
  },
}

-- Windows-only keybindings
if is_windows then
  table.insert(config.keys, {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
  })
  table.insert(config.keys, {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  })
  table.insert(config.keys, {
    key = 'r',
    mods = 'CTRL|ALT',
    action = wezterm.action.ReloadConfiguration,
  })
  table.insert(config.keys, {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  })
end

-- ============================================================================
-- GUI startup event (Windows only)
-- ============================================================================

if is_windows then
  wezterm.on('gui-startup', function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    local gui = window:gui_window()
    gui:set_position(-1, 0)
    gui:set_inner_size(3440, 1440)
  end)
end

return config
