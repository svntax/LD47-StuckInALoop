extends Node2D

onready var area = $Area2D
# In degrees
onready var rotation_speed = 15

func _physics_process(delta):
	rotation_degrees += rotation_speed * delta

func get_radius():
	return area.get_child(0).shape.radius
