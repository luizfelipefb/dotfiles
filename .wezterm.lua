-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- domain
config.default_domain = 'WSL:Arch'

-- visual
config.color_scheme = 'catppuccin-mocha'
config.font = wezterm.font 'Cousine Nerd Font Mono'
config.font_size = 10.0

-- window
-- config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'
config.enable_tab_bar = false
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- keybindings
config.keys = {
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain', cwd = '/home/luizfelipefb' },
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain', cwd = '/home/luizfelipefb' },
  },
}

-- center the window on startup
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local width, height = 1600, 1000
  local tab, pane, window = wezterm.mux.spawn_window {
    position = {
      x = (screen.width - width) / 2,
      y = (screen.height - height) / 2,
      origin = 'ActiveScreen'
    }
  }
  window:gui_window():set_inner_size(width, height)
end)

-- and finally, return the configuration to wezterm
return config