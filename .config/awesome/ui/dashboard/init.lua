-- local dpi = require("beautiful.xresources").apply_dpi
-- local cols_size = dpi(6) * 10 * 2
-- local rows_size = dpi(6) * 10 * 2


local function box_widget(widgets, width, height)
    return wibox.widget({
        widgets,
        forced_width = width,
        forced_height = height,
        -- border_width = beautiful.border_width,
        -- border_color = beautiful.common.secondary,
        widget = wibox.container.background,
    })
end

local clock_widget = require("ui.dashboard.clock")
local clock = box_widget(clock_widget, 100, 80)

-- local calendar_widget = require("ui.dashboard.calendar")
-- local calendar = box_widget(calendar_widget, cols_size * 2, rows_size * 2)

-- local countdown_widget = require("ui.dashboard.countdown")
-- local countdown = box_widget(countdown_widget, cols_size * 2, rows_size * 1)

-- local powermenu_widget = require("ui.dashboard.powermenu")
-- local powermenu = box_widget(powermenu_widget, cols_size * 1, rows_size * 4)

-- local notifications_widget = require("ui.dashboard.notifications")
-- local notifications = box_widget(notifications_widget, cols_size * 3, rows_size * 4)




awful.screen.connect_for_each_screen(function(s)
    -- awful.spawn("kitty --class dash1 --name DASH1 -e bpytop", {
    --     -- rule = ,
    --     floating  = true,
    --     -- is_fixed = true,
    --     immobilized = true,
    --     -- dockable = true,
    --     -- sticky = true,
    --     titlebars_enabled = false,
    --     -- requests_no_titlebar = true,
    --     rule = { instance = "dash1" },
    --     screen = s,
    --     -- type = "",
    --     border_width = 0,
    --     border_color = '#777777',
    --     ontop = false,
    --     x = 400,
    --     y = 200,
    --     height = 700,
    --     width = 1000,
    --     tag       = awful.tag.find_by_name(s, "nice"),
    --     -- placement = awful.placement.centered,
    --     -- shape = gears.shape.rounded_rect,
    -- })
    
-- 	s.test = wibox {
-- 		-- widget = {
-- 		-- 	clock,
-- 		-- 	cpuview,
-- 		-- 	memview,
-- 		-- 	nil,
-- 		-- 	layout = wibox.layout.align.horizontal,
-- 		-- },
-- 		-- type = "dock",
-- 		-- drawable = true,
-- 	    border_color   = '#777777',
-- 	    border_width   = 0,
-- 		visible        = true,
-- 	    ontop          = false,
-- 	    width  = 200,
-- 	    height = 100,
-- 	    x              = 300,
-- 	    y              = 300,
-- 	    -- placement      = awful.placement.centered,
-- 	    shape          = gears.shape.rounded_rect,
-- 	}
--     s.test:setup({
-- 		clock,
-- 		cpuview,
-- 		memview,
-- 		nil,
-- 		layout = wibox.layout.align.horizontal,
-- 	})

--     s.test1 = wibox {
-- 		widget = awful.widget.tasklist {
-- 	        screen   = screen[1],
-- 	        filter   = awful.widget.tasklist.filter.allscreen,
-- 	        buttons  = tasklist_buttons,
-- 	        style    = {
-- 	            shape = gears.shape.rounded_rect,
-- 	        },
-- 	        layout   = {
-- 	            spacing = 5,
-- 	            forced_num_rows = 2,
-- 	            layout = wibox.layout.grid.horizontal
-- 	        },
-- 	        widget_template = {
-- 	            {
-- 	                {
-- 	                    id     = 'clienticon',
-- 	                    widget = awful.widget.clienticon,
-- 	                },
-- 	                margins = 4,
-- 	                widget  = wibox.container.margin,
-- 	            },
-- 	            id              = 'background_role',
-- 	            forced_width    = 48,
-- 	            forced_height   = 48,
-- 	            widget          = wibox.container.background,
-- 	            create_callback = function(self, c, index, objects) --luacheck: no unused
-- 	                self:get_children_by_id('clienticon')[1].client = c
-- 	            end,
-- 	        },
-- 	    },
-- 	    border_color   = '#777777',
-- 	    border_width   = 0,
-- 		visible        = true,
-- 	    ontop          = false,
-- 	    width  = 200,
-- 	    height = 100,
-- 	    x              = 510,
-- 	    y              = 300,
-- 	    -- placement      = awful.placement.centered,
-- 	    shape          = gears.shape.rounded_rect,
-- 	}

--     s.test2 = wibox {
-- 		widget = awful.widget.tasklist {
-- 	        screen   = screen[1],
-- 	        filter   = awful.widget.tasklist.filter.allscreen,
-- 	        buttons  = tasklist_buttons,
-- 	        style    = {
-- 	            shape = gears.shape.rounded_rect,
-- 	        },
-- 	        layout   = {
-- 	            spacing = 5,
-- 	            forced_num_rows = 2,
-- 	            layout = wibox.layout.grid.horizontal
-- 	        },
-- 	        widget_template = {
-- 	            {
-- 	                {
-- 	                    id     = 'clienticon',
-- 	                    widget = awful.widget.clienticon,
-- 	                },
-- 	                margins = 4,
-- 	                widget  = wibox.container.margin,
-- 	            },
-- 	            id              = 'background_role',
-- 	            forced_width    = 48,
-- 	            forced_height   = 48,
-- 	            widget          = wibox.container.background,
-- 	            create_callback = function(self, c, index, objects) --luacheck: no unused
-- 	                self:get_children_by_id('clienticon')[1].client = c
-- 	            end,
-- 	        },
-- 	    },
-- 	    border_color   = '#777777',
-- 	    border_width   = 0,
-- 		visible        = true,
-- 	    ontop          = false,
-- 	    width  = 200,
-- 	    height = 100,
-- 	    x              = 300,
-- 	    y              = 410,
-- 	    -- placement      = awful.placement.centered,
-- 	    shape          = gears.shape.rounded_rect,
-- 	}

--     s.test3 = wibox {
-- 		widget = awful.widget.tasklist {
-- 	        screen   = screen[1],
-- 	        filter   = awful.widget.tasklist.filter.allscreen,
-- 	        buttons  = tasklist_buttons,
-- 	        style    = {
-- 	            shape = gears.shape.rounded_rect,
-- 	        },
-- 	        layout   = {
-- 	            spacing = 5,
-- 	            forced_num_rows = 2,
-- 	            layout = wibox.layout.grid.horizontal
-- 	        },
-- 	        widget_template = {
-- 	            {
-- 	                {
-- 	                    id     = 'clienticon',
-- 	                    widget = awful.widget.clienticon,
-- 	                },
-- 	                margins = 4,
-- 	                widget  = wibox.container.margin,
-- 	            },
-- 	            id              = 'background_role',
-- 	            forced_width    = 48,
-- 	            forced_height   = 48,
-- 	            widget          = wibox.container.background,
-- 	            create_callback = function(self, c, index, objects) --luacheck: no unused
-- 	                self:get_children_by_id('clienticon')[1].client = c
-- 	            end,
-- 	        },
-- 	    },
-- 	    border_color   = '#777777',
-- 	    border_width   = 0,
-- 		visible        = true,
-- 	    ontop          = false,
-- 	    width  = 200,
-- 	    height = 100,
-- 	    x              = 510,
-- 	    y              = 410,
-- 	    -- placement      = awful.placement.centered,
-- 	    shape          = gears.shape.rounded_rect,
-- 	}
end)


-- awful.placement.bottom_left(dashboard, {
--     margins = beautiful.useless_gap * 2,
-- })

-- function dashboard:toggle()
--     self.visible = not self.visible
-- end

-- awful.keyboard.append_global_keybindings({
--     awful.key({ keys.super }, "d", function()
--         dashboard:toggle()
--     end, { description = "Toggle dashboard", group = "actions" }),
-- })