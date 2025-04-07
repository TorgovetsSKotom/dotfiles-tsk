

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    -- awful.key({},"F9", function() awful.util.spawn("ddcutil setvcp 10 16 && ddcutil setvcp 12 11")
    -- end, { description = "brightness down", group = "launcher" }),
    --     awful.key({},"F10", function() awful.util.spawn("ddcutil setvcp 10 54 && ddcutil setvcp 12 42")
    -- end, { description = "brightness up", group = "launcher" }),


    awful.key({},"Print", function() awful.util.spawn("flameshot gui")
    end, { description = "flameshot", group = "launcher" }),
    awful.key({"Shift"},"Print", function() awful.util.spawn("flameshot launcher")
    end, { description = "flameshot launcher", group = "launcher" }),

	awful.key({ modkey }, "z", function() term_scratch:toggle()
	end, {description = "dropdown terminal", group = "launcher"}),
	-- awful.key({ modkey }, "x", function() fm_scratch:toggle()
	-- end, {description = "dropdown file manager", group = "launcher"}),

	awful.key({ modkey }, "c", function() awful.util.spawn("code")
	end, {description = "vscode", group = "launcher"}),
	awful.key({ modkey }, "v", function() awful.util.spawn("vivaldi")
	end, {description = "vivaldi", group = "launcher"}),
		awful.key({ modkey }, "f", function() awful.util.spawn("pcmanfm")
	end, {description = "pcmanfm", group = "launcher"}),
	
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

-- Set keys
root.keys(globalkeys)
-- }}}




-- local gfs           = require("gears.filesystem")
-- local themes_path   = gfs.get_themes_dir()

-- Default modkey.
-- Modkey: Mod4 (Super key) or Mod1 (Alt key)
modkey = "Mod4"
alt = "Mod1"

-- -- AwesomeWM
-- awful.keyboard.append_global_keybindings({
--     awful.key({ modkey, }, "s", hotkeys_popup.show_help,
--         { description = "help menu", group = "awesome" }),
--     awful.key({ modkey, "Control" }, "r", awesome.restart,
--         { description = "reload awesome", group = "awesome" }),
--     awful.key({ modkey, "Control" }, "m", function()
--         awful.util.spawn("i3lock")
--     end, { description = "lockscreen", group = "awesome" }),
--     awful.key({ modkey }, "Escape", function()
--         awesome.emit_signal("module::powermenu:show")
--     end, { description = "powermenu", group = "awesome" }),
--     awful.key({ modkey }, "c", function()
--         awesome.emit_signal("module::dashboard:show")
--     end, { description = "dashboard", group = "awesome" })
-- })
--
-- -- Launcher
-- awful.keyboard.append_global_keybindings({
--     awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
--         { description = "terminal", group = "launcher" }),
--     awful.key({ modkey }, "d", function()
--         awful.spawn("rofi -show drun -show-icons &>> /tmp/rofi.log")
--     end, { description = "rofi", group = "launcher" }),
--     awful.key({ modkey }, "p", function()
--         awful.spawn("thunar")
--     end, { description = "file manager", group = "launcher" }),
--     awful.key({}, "Print", function()
--         local home = os.getenv("HOME")
--         local filepath = home .. "/Pictures/Screenshots/" .. os.date("%Y-%m-%d_%H:%M:%S") .. ".png"
--         awful.spawn.with_shell('maim -u ' .. filepath)
--         naughty.notify({
--             icon = filepath,
--             title = "Screenshot taken",
--             text = filepath
--         })
--     end, { description = "screen screenshot", group = "launcher" }),
--     awful.key({ "Shift" }, "Print", function()
--         local home = os.getenv("HOME")
--         local filepath = home .. "/Pictures/Screenshots/" .. os.date("%Y-%m-%d_%H:%M:%S") .. ".png"
--         awful.spawn.with_shell('maim -s --format png -u ' .. filepath .. '| xclip -selection clipboard -t image/png -i')
--         naughty.notify({
--             icon = filepath,
--             title = "Select Area for Screenshot",
--             text = "Screenshot will be saved"
--         })
--     end, { description = "screenshot area", group = "launcher" }),
--     awful.key({ "Control" }, "Print", function()
--         local home = os.getenv("HOME")
--         local filepath = home .. "/Pictures/Screenshots/" .. os.date("%Y-%m-%d_%H:%M:%S") .. ".png"
--         awful.spawn.with_shell("maim -s --format png -u | xclip -selection clipboard -t image/png -i")
--         naughty.notify({
--             icon = filepath,
--             title = "Select Area for Screenshot",
--             text = "Screenshot will be saved to clipboard"
--         })
--     end, { description = "clipboard area", group = "launcher" }),
-- })
--
-- -- Screen
-- awful.keyboard.append_global_keybindings({
--     awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
--         { description = "focus next screen", group = "screen" }),
--
--     awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
--         { description = "focus previous screen", group = "screen" }),
-- })
--
-- -- System
-- awful.keyboard.append_global_keybindings({
--     awful.key({}, "XF86AudioRaiseVolume", function()
--         awesome.emit_signal("volume::increase")
--     end, { description = "raise volume", group = "control / media" }),
--     awful.key({}, "XF86AudioLowerVolume", function()
--         awesome.emit_signal("volume::decrease")
--     end, { description = "lower volume", group = "control / media" }),
--     awful.key({}, "XF86AudioMute", function()
--         awesome.emit_signal("volume::mute")
--     end, { description = "toggle volume", group = "control / media" }),
--     awful.key({}, "XF86AudioMicMute", function()
--         awesome.emit_signal("mic::toggle")
--     end, { description = "toggle mic", group = "control / media" }),
--     awful.key({}, "XF86AudioPlay", function()
--         awful.spawn("playerctl play-pause", false)
--     end, { description = "audio Play", group = "control / media" }),
--     awful.key({}, "XF86AudioNext", function()
--         awful.spawn("playerctl next", false)
--     end, { description = "audio Next", group = "control / media" }),
--     awful.key({}, "XF86AudioPrev", function()
--         awful.spawn("playerctl previous", false)
--     end, { description = "audio Prev", group = "control / media" }),
--     awful.key({}, "XF86MonBrightnessUp", function()
--         awesome.emit_signal("brightness::increase")
--     end, { description = "brightness up", group = "control / media" }),
--     awful.key({}, "XF86MonBrightnessDown", function()
--         awesome.emit_signal("brightness::decrease")
--     end, { description = "brightness down", group = "control / media" }),
-- })
--
-- -- Layout
-- awful.keyboard.append_global_keybindings({
--     awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
--         { description = "urgent client", group = "layout" }),
--     awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
--         { description = "next layout", group = "layout" }),
--     awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
--         { description = "previous layout", group = "layout" }),
--     awful.key({ modkey, "Control" }, "l", function() awful.tag.incmwfact(0.05) end,
--         { description = "increase master client", group = "layout" }),
--     awful.key({ modkey, "Control" }, "h", function() awful.tag.incmwfact(-0.05) end,
--         { description = "decrease master client", group = "layout" }),
--     awful.key {
--         modifiers   = { modkey },
--         keygroup    = "numrow",
--         description = "to tag",
--         group       = "layout",
--         on_press    = function(index)
--             local screen = awful.screen.focused()
--             local tag = screen.tags[index]
--             if tag then
--                 tag:view_only()
--             end
--         end,
--     },
--     awful.key {
--         modifiers   = { modkey, "Control" },
--         keygroup    = "numrow",
--         description = "toggle tag",
--         group       = "layout",
--         on_press    = function(index)
--             local screen = awful.screen.focused()
--             local tag = screen.tags[index]
--             if tag then
--                 awful.tag.viewtoggle(tag)
--             end
--         end,
--     },
--     awful.key {
--         modifiers   = { modkey, "Shift" },
--         keygroup    = "numrow",
--         description = "move focused client to tag",
--         group       = "layout",
--         on_press    = function(index)
--             if client.focus then
--                 local tag = client.focus.screen.tags[index]
--                 if tag then
--                     client.focus:move_to_tag(tag)
--                 end
--             end
--         end,
--     },
--     awful.key {
--         modifiers   = { modkey, "Control", "Shift" },
--         keygroup    = "numrow",
--         description = "toggle focused client on tag",
--         group       = "layout",
--         on_press    = function(index)
--             if client.focus then
--                 local tag = client.focus.screen.tags[index]
--                 if tag then
--                     client.focus:toggle_tag(tag)
--                 end
--             end
--         end,
--     },
--     awful.key {
--         modifiers   = { modkey },
--         keygroup    = "numpad",
--         description = "select layout directly",
--         group       = "layout",
--         on_press    = function(index)
--             local t = awful.screen.focused().selected_tag
--             if t then
--                 t.layout = t.layouts[index] or t.layout
--             end
--         end,
--     },
--     awful.key({ modkey, }, "Left", awful.tag.viewprev,
--         { description = "view previous", group = "layout" }),
--     awful.key({ modkey, }, "Right", awful.tag.viewnext,
--         { description = "view next", group = "layout" })
-- })
--
-- -- Client
-- client.connect_signal("request::default_keybindings", function()
--     awful.keyboard.append_client_keybindings({
--         awful.key({ modkey, "Shift" }, "h", function() awful.client.swap.bydirection("left") end,
--             { description = "swap left", group = "client" }),
--         awful.key({ modkey, "Shift" }, "l", function() awful.client.swap.bydirection("right") end,
--             { description = "swap right", group = "client" }),
--         awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.bydirection("down") end,
--             { description = "swap down", group = "client" }),
--         awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.bydirection("up") end,
--             { description = "swap up", group = "client" }),
--         awful.key({ modkey, }, "j",
--             function()
--                 awful.client.focus.bydirection("down")
--             end,
--             { description = "focus down", group = "client" }
--         ),
--         awful.key({ modkey, }, "k",
--             function()
--                 awful.client.focus.bydirection("up")
--             end,
--             { description = "focus up", group = "client" }
--         ),
--         awful.key({ modkey, }, "l",
--             function()
--                 awful.client.focus.bydirection("right")
--             end,
--             { description = "focus right", group = "client" }
--         ),
--         awful.key({ modkey, }, "h",
--             function()
--                 awful.client.focus.bydirection("left")
--             end,
--             { description = "focus left", group = "client" }
--         ),
--         awful.key({ modkey, }, "f", function(c)
--             c.fullscreen = not c.fullscreen
--             c:raise()
--         end, { description = "toggle fullscreen", group = "client" }),
--
--         awful.key({ modkey, }, "q", function(c)
--             c:kill()
--         end, { description = "close", group = "client" }),
--
--         awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
--             { description = "toggle floating", group = "client" }),
--
--         awful.key({ modkey, "Control" }, "Return", function(c)
--             c:swap(awful.client.getmaster())
--         end, { description = "move to master", group = "client" }),
--
--         awful.key({ modkey, }, "o", function(c)
--             c:move_to_screen()
--         end, { description = "move to screen", group = "client" }),
--
--         awful.key({ modkey, }, "n", function(c)
--             -- The client currently has the input focus, so it cannot be
--             -- minimized, since minimized clients can't have the focus.
--             c.minimized = true
--         end, { description = "minimize", group = "client" }),
--         awful.key({ modkey, }, "m", function(c)
--             c.maximized = not c.maximized
--             c:raise()
--         end, { description = "(un)maximize", group = "client" }),
--         awful.key({ modkey, "Control" }, "m", function(c)
--             c.maximized_vertical = not c.maximized_vertical
--             c:raise()
--         end, { description = "(un)maximize vertically", group = "client" }),
--         awful.key({ modkey, "Shift" }, "m", function(c)
--             c.maximized_horizontal = not c.maximized_horizontal
--             c:raise()
--         end, { description = "(un)maximize horizontally", group = "client" }),
--         awful.key({ modkey, }, "Tab",
--             function()
--                 awful.client.focus.history.previous()
--                 if client.focus then
--                     client.focus:raise()
--                 end
--             end,
--             { description = "go back", group = "client" }),
--         awful.key({ modkey, "Control" }, "n",
--             function()
--                 local c = awful.client.restore()
--                 -- Focus restored client
--                 --if c then
--                 --    c:activate { raise = true, context = "key.unminimize" }
--                 --end
--                 if c then
--                     c:emit_signal(
--                         "request::activate", "key.unminimize", { raise = true }
--                     )
--                 end
--             end,
--             { description = "restore minimized", group = "client" }),
--     })
-- end)

-- {{{ Mouse bindings
clientbuttons = gears.table.join(
	-- Left-click on a client to focus
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	
	-- Modkey + Left-click to move a client
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),

	-- Modkey + Right-click to resize a client
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

root.buttons(gears.table.join(
	-- Right-click on the desktop to toggle the main menu
	awful.button({}, 3, function() mymainmenu:toggle() end),

	-- Scroll up / down to view previous / next tag	
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}
