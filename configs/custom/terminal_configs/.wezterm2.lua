local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.leader = { key = 'Space', mods = 'CTRL'}
config.xcursor_theme = 'Adwaita'  -- or whatever theme you use
-- Smart navigation between WezTerm panes and Neovim splits
local function is_vim(pane)
  local process_info = pane:get_foreground_process_info()
  local process_name = process_info and process_info.name
  
  -- Check process name first
  if process_name == "nvim" or process_name == "vim" then
    return true
  end
  
  -- Fallback for Flatpak: check window title
  local title = pane:get_title()
  return title:find("nvim") or title:find("vim") or title:find("Nvim")
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "ALT" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "ALT" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 6 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

config.color_scheme = 'LiquidCarbon'

config.font_size = 12.0

config.window_decorations = "NONE"

config.window_background_opacity = 0.8

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.use_resize_increments = true

config.window_frame = {
  border_left_width = '0cell',
  border_right_width = '0cell',
  border_bottom_height = '0cell',
  border_top_height = '0cell',
  font_size = 12
}

config.keys = {
  -- Smart navigation between panes (MUST be first to work with Neovim)
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),
  -- Resize panes with Alt
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
  -- Debug key to check process detection
  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action_callback(function(win, pane)
      local process_info = pane:get_foreground_process_info()
      if process_info then
        win:toast_notification('WezTerm', 'Process: ' .. (process_info.name or 'unknown'), nil, 4000)
      else
        win:toast_notification('WezTerm', 'No process info', nil, 4000)
      end
    end),
  },
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
    key = 'b',
    mods = 'CMD',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if not overrides.window_background_opacity or overrides.window_background_opacity == 1.8 then
        overrides.window_background_opacity = .8
      else
        overrides.window_background_opacity = 1.0
      end
      window:set_config_overrides(overrides)
    end),
  },
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_decorations == "NONE" then
        overrides.window_decorations = "TITLE|RESIZE"
      else
        overrides.window_decorations = "NONE"
      end
      window:set_config_overrides(overrides)
    end),
  },
  -- New tab
  {
    key = 't',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  -- Navigate between tabs
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(2),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(0),
  },
  -- Rename tab
  {
    key = ',',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- Split panes
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'x',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.QuitApplication,
  },
}

return config
