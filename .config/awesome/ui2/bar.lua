

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

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, false)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	-- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	local names = { "nice", "nowork", "work", "web/full", "max" }
	local l = awful.layout.suit -- Just to save some typing: use an alias.
	local l_bl = bling.layout
	local layouts = { l_bl.centered, l.tile, l_bl.equalarea, l.max, l.max }
	awful.tag(names, s, layouts)
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

	-- s.mytaglist = awful.widget.taglist({
	-- 	screen  = s,
	-- 	filter  = awful.widget.taglist.filter.all,
	-- 	-- style   = {
	-- 	-- 	shape = gears.shape.powerline
	-- 	-- },
	-- 	-- layout   = {
	-- 	-- 	spacing = -12,
	-- 	-- 	spacing_widget = {
	-- 	-- 		color  = '#dddddd',
	-- 	-- 		shape  = gears.shape.powerline,
	-- 	-- 		widget = wibox.widget.separator,
	-- 	-- 	},
	-- 	-- 	layout  = wibox.layout.fixed.horizontal
	-- 	-- },
	-- 	widget_template = {
	-- 		{
	-- 			{
	-- 				{
	-- 					{
	-- 						{
	-- 							id     = 'index_role',
	-- 							widget = wibox.widget.textbox,
	-- 						},
	-- 						margins = 4,
	-- 						widget  = wibox.container.margin,
	-- 					},
	-- 					bg     = '#dddddd',
	-- 					shape  = gears.shape.circle,
	-- 					widget = wibox.container.background,
	-- 				},
	-- 				{
	-- 					{
	-- 						id     = 'icon_role',
	-- 						widget = wibox.widget.imagebox,
	-- 					},
	-- 					margins = 2,
	-- 					widget  = wibox.container.margin,
	-- 				},
	-- 				{
	-- 					id     = 'text_role',
	-- 					widget = wibox.widget.textbox,
	-- 				},
	-- 				layout = wibox.layout.fixed.horizontal,
	-- 			},
	-- 			left  = 18,
	-- 			right = 18,
	-- 			widget = wibox.container.margin
	-- 		},
	-- 		id     = 'background_role',
	-- 		widget = wibox.container.background,
	-- 		-- Add support for hover colors and an index label
	-- 		create_callback = function(self, c3, index, objects) --luacheck: no unused args
	-- 			self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
	-- 			self:connect_signal('mouse::enter', function()
	
	-- 				-- BLING: Only show widget when there are clients in the tag
	-- 				if #c3:clients() > 0 then
	-- 					-- BLING: Update the widget with the new tag
	-- 					awesome.emit_signal("bling::tag_preview::update", c3)
	-- 					-- BLING: Show the widget
	-- 					awesome.emit_signal("bling::tag_preview::visibility", s, true)
	-- 				end
	
	-- 				if self.bg ~= '#ff0000' then
	-- 					self.backup     = self.bg
	-- 					self.has_backup = true
	-- 				end
	-- 				self.bg = '#ff0000'
	-- 			end)
	-- 			self:connect_signal('mouse::leave', function()
	
	-- 				-- BLING: Turn the widget off
	-- 				awesome.emit_signal("bling::tag_preview::visibility", s, false)
	
	-- 				if self.has_backup then self.bg = self.backup end
	-- 			end)
	-- 		end,
	-- 		update_callback = function(self, c3, index, objects) --luacheck: no unused args
	-- 			self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
	-- 		end,
	-- 	},
	-- 	buttons = taglist_buttons
	-- })

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

	-- local cols_size = dpi(6) * 10 * 2
	-- -- local rows_size = dpi(6) * 10 * 2

	-- -- local function box_widget(widgets, width, height)
	-- -- 	return wibox.widget({
	-- -- 		widgets,
	-- -- 		forced_width = width,
	-- -- 		forced_height = height,
	-- -- 		widget = wibox.container.background,
	-- -- 	})
	-- -- end

	-- -- local clock_widget = require("ui.dashboard.clock")
	-- -- local clock = box_widget(clock_widget, cols_size * 2, rows_size * 1)

	-- local workarea = screen.primary.workarea

	-- local dashboard = wibox({
	-- 	widget = {
	-- 		{
	-- 			{
	-- 				nicewidget,
	-- 				cpuview,
	-- 				memview,
	-- 				volumeview,
	-- 				mykeyboardlayout,
	-- 				layout = wibox.layout.fixed.vertical,
	-- 			},
	-- 			powermenu,
	-- 			layout = wibox.layout.fixed.horizontal,
	-- 		},
	-- 		-- notifications_widget,
	-- 		nil,
	-- 		layout = wibox.layout.align.vertical,
	-- 	},
	-- 	type = "dock",
	-- 	screen = screen.primary,
	-- 	visible = false,
	-- 	ontop = true,
	-- 	width = cols_size * 3.,
	-- 	height = workarea.height - (beautiful.useless_gap * 4) - (beautiful.border_width * 2), -- - beautiful.wibar_height,
	-- 	border_width = 0,
	-- 	border_color = '#777777',
	-- })

	-- awful.placement.bottom_left(dashboard, {
	-- 	margins = beautiful.useless_gap * 2,
	-- })

	-- function dashboard:toggle()
	-- 	self.visible = not self.visible
	-- end
	-- dashboard:toggle()
	-- awful.keyboard.append_global_keybindings({
	-- 	awful.key({ modkey }, "d", function()
	-- 		dashboard:toggle()
	-- 	end, { description = "Toggle dashboard", group = "actions" }),
	-- })
	-- s.test = wibox.widget {
	-- 	awful.widget.tasklist {
	--         screen   = screen[1],
	--         filter   = awful.widget.tasklist.filter.allscreen,
	--         buttons  = tasklist_buttons,
	--         style    = {
	--             shape = gears.shape.rounded_rect,
	--         },
	--         layout   = {
	--             spacing = 5,
	--             forced_num_rows = 2,
	--             layout = wibox.layout.grid.horizontal
	--         },
	--         widget_template = {
	--             {
	--                 {
	--                     id     = 'clienticon',
	--                     widget = awful.widget.clienticon,
	--                 },
	--                 margins = 4,
	--                 widget  = wibox.container.margin,
	--             },
	--             id              = 'background_role',
	--             forced_width    = 48,
	--             forced_height   = 48,
	--             widget          = wibox.container.background,
	--             create_callback = function(self, c, index, objects) --luacheck: no unused
	--                 self:get_children_by_id('clienticon')[1].client = c
	--             end,
	--         },
	--     },
	-- 	widget = wibox.container.background,
	--     border_color   = '#777777',
	--     border_width   = 0,
	--     ontop          = false,
	--     minimum_width  = 200,
	--     minimum_height = 100,
	--     x              = 300,
	--     y              = 300,
	--     -- placement      = awful.placement.centered,
	--     shape          = gears.shape.rounded_rect,
	-- }
	-- s.test_2 = awful.popup {
	--     widget = awful.widget.tasklist {
	--         screen   = screen[1],
	--         filter   = awful.widget.tasklist.filter.allscreen,
	--         buttons  = tasklist_buttons,
	--         style    = {
	--             shape = gears.shape.rounded_rect,
	--         },
	--         layout   = {
	--             spacing = 5,
	--             forced_num_rows = 2,
	--             layout = wibox.layout.grid.horizontal
	--         },
	--         widget_template = {
	--             {
	--                 {
	--                     id     = 'clienticon',
	--                     widget = awful.widget.clienticon,
	--                 },
	--                 margins = 4,
	--                 widget  = wibox.container.margin,
	--             },
	--             id              = 'background_role',
	--             forced_width    = 48,
	--             forced_height   = 48,
	--             widget          = wibox.container.background,
	--             create_callback = function(self, c, index, objects) --luacheck: no unused
	--                 self:get_children_by_id('clienticon')[1].client = c
	--             end,
	--         },
	--     },
	--     type           = "desktop",
	--     border_color   = '#777777',
	--     border_width   = 0,
	--     ontop          = false,
	--     minimum_width  = 200,
	--     minimum_height = 100,
	--     x              = 600,
	--     y              = 300,
	--     -- placement      = awful.placement.centered,
	--     shape          = gears.shape.rounded_rect,
	-- }
end)
-- }}}
