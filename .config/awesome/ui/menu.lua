

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
	{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, },
	{ "manual",      terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart",     awesome.restart },
	{ "quit", function() awesome.quit() end, },
}

local poweroptions = {
    -- { "lock", function() awful.spawn("i3lock") end },
    { "logout", function() awesome.quit() end },
    { "reboot", function() awful.spawn("reboot") end },
    { "shutdown", function() awful.spawn("shutdown now") end },
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
		{ "power", poweroptions},
	},
})

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal
-- }}}
