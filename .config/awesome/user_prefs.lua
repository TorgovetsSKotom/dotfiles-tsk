
-- Theme handling library
local theme_dir = gears.filesystem.get_configuration_dir() .. "themes/"
local themes = {
	"default",
	"blackburn",
	"copland",
	"dremora",
	"holo",
	"multicolor",
	-- "rosybrown",
}

wallpapers = {
   	theme_dir .. "default/background.jpg"
    -- "/run/media/tsk/FATAL/Обои ласт/Обои upscaled"
}

local chosen_theme = themes[1]
beautiful.init(theme_dir .. "/" .. chosen_theme .. "/theme.lua")
terminal = "kitty"
editor = os.getenv("EDITOR") or "micro"
editor_cmd = terminal .. " -e " .. editor
awful.util.terminal = terminal

modkey = "Mod4"
altkey = "Mod1"
