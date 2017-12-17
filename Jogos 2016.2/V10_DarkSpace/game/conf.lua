function love.conf(t)
  t.identity = nil
  t.console = false
  t.window.width = 800
  t.window.height = 600
  t.window.bordeless = false
  t.window.fullscreen = false
  t.window.fullscreentype = "desktop"
  t.window.title = "Dark Space"
  t.modules.joystick = false
  t.identity = "DarkSpace"
end