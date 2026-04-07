-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- domain
local is_linux = wezterm.target_triple:find("linux") ~= nil
if is_linux then
	config.default_domain = "WSL:Arch"
end

-- visual
config.color_scheme = "catppuccin-mocha"
config.font = wezterm.font("Cousine Nerd Font Mono")
config.font_size = 12.0

-- window
-- config.window_decorations = 'RESIZE'
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}

-- keybindings
config.keys = {
	{ key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain", cwd = "/home/luizfelipefb" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain", cwd = "/home/luizfelipefb" }) },
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
}

-- 1600x1000 pixels is roughly 200 cols and 52 rows (depending on your font)
config.initial_cols = 200
config.initial_rows = 50

-- center the window on startup
wezterm.on("gui-startup", function()
    local screen = wezterm.gui.screens().active
    local width_px, height_px = 1600, 1000
    
    local x = (screen.width - width_px) / 2
    local y = (screen.height - height_px) / 2

    wezterm.mux.spawn_window({
        position = {
            x = math.floor(x),
            y = math.floor(y),
            origin = { Screen = screen },
        },
    })
end)

-- and finally, return the configuration to wezterm
return config
