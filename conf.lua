function love.conf(t)
	t.window.title = "Bazinga blaster"
	t.window.width = 1920
	t.window.height = 1080
	t.window.vsync = true

	-- Disable modules you aren't using to improve performance
	t.modules.joystick = false
	t.modules.physics = false
end