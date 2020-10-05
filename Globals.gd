extends Node

const MIN_DASH_SPEED = 184

var score = 0
var current_map = 0

var high_scores : Array = [0, 0]

func _ready():
	OS.window_size = Vector2(640, 480)
	# Center the window after resizing
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	# Save data handling
	load_data()

func save_data():
	var file = File.new()
	var err = file.open("user://save_game.dat", File.WRITE)
	if err == OK:
		file.store_line(to_json(high_scores))
		file.close()

func load_data():
	var file = File.new()
	if not file.file_exists("user://save_game.dat"):
		return
	
	var err = file.open("user://save_game.dat", File.READ)
	if err == OK:
		var content = parse_json(file.get_as_text())
		if typeof(content) == TYPE_ARRAY:
			high_scores = content
			if high_scores.size() != 2:
				high_scores = [0, 0]
			if high_scores[0] < 0:
				high_scores[0] = 0
			if high_scores[1] < 0:
				high_scores[1] = 0
		file.close()

# Update the high score for the current map
func update_high_score() -> bool:
	if score > high_scores[current_map]:
		high_scores[current_map] = score
		return true
	return false
