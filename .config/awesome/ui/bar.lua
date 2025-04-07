

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()



-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

-- local gfs = require("gears.filesystem")
-- beautiful.wallpaper = gfs.get_themes_dir() .. "default/background.jpg"

-- local function set_wallpaper(s)
-- 	-- Wallpaper
-- 	if beautiful.wallpaper then
-- 		local wallpaper = beautiful.wallpaper
-- 		-- If wallpaper is a function, call it with the screen
-- 		if type(wallpaper) == "function" then
-- 			wallpaper = wallpaper(s)
-- 		end
-- 		gears.wallpaper.maximized(wallpaper, s, false)
-- 	end
-- end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)


-- wallpapers = {
-- 	gfs.get_themes_dir() .. "default/background.jpg"
-- }

-- theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/default/background.jpg"
-- bling.module.wallpaper.setup {
-- 	wallpaper = gfs.get_themes_dir() .. "default/background.jpg",
-- 	position = "maximized",
-- 	change_timer = 10,
-- 	screens = screen,
-- 	set_function = simple
-- }

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	-- set_wallpaper(s)
	-- gears.wallpaper.maximized(gfs.get_themes_dir() .. "default/background.jpg", s)

	-- Each screen has its own tag table.
	local names_1 = { "1", "2", "3", "4", "5" }
	local names_2 = { "nice", "nowork", "work", "web/full", "max" }
	local l = awful.layout.suit -- Just to save some typing: use an alias.
	local l_bl = bling.layout
	local layouts = { l_bl.centered, l.tile, l_bl.equalarea, l.max, l.max }
	
	if s.index == 1 then
		awful.tag(names_1, s, layouts)
	elseif s.index == 2 then
		awful.tag(names_2, s, layouts)
	end
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({position = "top", screen = s, height = 25 })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			nicewidget,
			cpuview,
			memview,
			volumeview,
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			-- calendarview,
			s.mylayoutbox,
		},
	})
end)
-- }}}
