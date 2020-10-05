extends Node

const MIN_DASH_SPEED = 184

var score = 0
var current_map = 0

var high_scores = [10, 0]

func _ready():
	OS.window_size = Vector2(640, 480)
	# Center the window after resizing
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

# Update the high score for the current map
func update_high_score() -> bool:
	if score > high_scores[current_map]:
		high_scores[current_map] = score
		return true
	return false
