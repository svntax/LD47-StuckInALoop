extends Node2D

const Balloon = preload("res://Balloon/Balloon.tscn")

onready var balloon_spawns = $BalloonSpawns
onready var balloons = $Balloons
onready var spawn_timer = $SpawnTimer

func _ready():
	spawn_balloon()

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
	Globals.points += 1
	spawn_timer.start(rand_range(0.5, 1))

func _on_SpawnTimer_timeout():
	spawn_balloon()
