
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

nicewidget = wibox.widget.textbox("It's nice to work!")

cpuview = cpu_widget({
	width = 70,
	step_width = 2,
	step_spacing = 0,
	color = "#434c5e",
})

memview = ram_widget()

volumeview = volume_widget({
	widget_type = "arc",
})

-- local calendarview = calendar_widget()

