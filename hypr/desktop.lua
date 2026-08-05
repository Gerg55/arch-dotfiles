-- monitors

hl.monitor({
  output = "DP-1",
  mode = "2560x1440@144",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "-1920x0",
  scale = 1,
})


-- window 

-- ignores maximize and minimize requests
hl.window_rule({
	name = "suppress-maximize-events",
	match = {
    class = ".*"
  },
	suppress_event = "maximize"
})

-- fixes dragging issues with xwayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
    class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true
})
