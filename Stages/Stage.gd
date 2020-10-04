extends Node2D

const Balloon = preload("res://Balloon/Balloon.tscn")

onready var balloon_spawns = $BalloonSpawns
onready var balloons = $Balloons
onready var spawn_timer = $SpawnTimer
onready var score_label = $UI/Score
onready var animation_player = $AnimationPlayer
onready var game_over_menu = $UI/GameOverMenu

onready var top_bound = $MapBounds/TopBound
onready var bottom_bound = $MapBounds/BottomBound
onready var left_bound = $MapBounds/LeftBound
onready var right_bound = $MapBounds/RightBound

func _ready():
	Globals.score = 0
	update_score()
	spawn_balloon()

func game_over():
	animation_player.play("game_over")
	var new_high_score = Globals.update_high_score()
	if new_high_score:
		game_over_menu.set_new_high_score_text(true)

# Spawn a balloon at a randomly picked spawn position
func spawn_balloon():
	# Create the balloon
	var i = randi() % balloon_spawns.get_child_count()
	var pos = balloon_spawns.get_child(i)
	var balloon = Balloon.instance()
	balloons.add_child(balloon)
	balloon.global_position = pos.global_position
	# Connect its popped signal
	balloon.connect("popped", self, "_on_balloon_popped")

func _on_balloon_popped():
	Globals.score += 1
	update_score()
	spawn_timer.start(rand_range(0.5, 1))

func update_score():
	game_over_menu.set_score(Globals.score)
	score_label.set_text("Score: " + str(Globals.score))

func _on_SpawnTimer_timeout():
	spawn_balloon()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		game_over_menu.set_active(true)
