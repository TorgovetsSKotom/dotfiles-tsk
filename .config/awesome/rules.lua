

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = 0,  -- beautiful.border_width
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
        		"Nitrogen",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"Main",
				"Touhou Hisoutensoku + Giuroll 0.6.12",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = {
			titlebars_enabled = function(c)
				return not c.requests_no_titlebar
			end,
		},
	},
	{ rule = { class = "steam" }, properties = { screen = 2, tag = "max" } },
	{ rule = { class = "Vivaldi" }, properties = { screen = 2, tag = "web/full" } },
	{ rule = { class = "firefox" }, properties = { screen = 2, tag = "web/full" } },
	{ rule = { class = "code-oss" }, properties = { screen = 2, tag = "work" } },
	{ rule = { name = "Visual Studio Code" }, properties = { screen = 2, tag = "work" } },
	{ rule = { class = "Joplin" }, properties = { screen = 2, tag = "web/full" } },
	{ rule = { class = "obsidian" }, properties = { screen = 2, tag = "web/full" } },
	{ rule = { name = "Picture in picture" }, properties = { floating = true } },
	-- { rule = { class = "eww" }, properties = { border_width = 0 } },
}
-- }}}
