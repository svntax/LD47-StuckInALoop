extends Area2D

onready var popped = false
onready var explosion_force = 300

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.get_parent() is Player:
		if not popped:
			var force = (body.global_position - global_position).normalized() * explosion_force
			body.get_parent().knockback(force)
			pop_balloon()

func pop_balloon():
	if popped:
		return
	popped = true
	
	queue_free()
