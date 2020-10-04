extends Node

const MIN_DASH_SPEED = 142

var points = 0

func _ready():
	OS.window_size = Vector2(640, 480)
	# Center the window after resizing
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
