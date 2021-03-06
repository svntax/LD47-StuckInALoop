extends Area2D

signal popped()

onready var animation_player = $AnimationPlayer
onready var pop_sfx = $PopSound
onready var score_sfx = $ScoreSound

onready var popped = false
onready var explosion_force = 300

func _ready():
	connect("body_entered", self, "_on_body_entered")
	animation_player.play("idle")
	animation_player.seek(rand_range(0, 1), true)

func _on_body_entered(body):
	if body.is_in_group("Players"):
		if not popped:
			var force = (body.global_position - global_position).normalized() * explosion_force
			body.get_parent().knockback(force)
			pop_balloon()

func pop_balloon():
	if popped:
		return
	popped = true
	pop_sfx.play()
	$ScoreSoundTimer.start()
	emit_signal("popped")
	animation_player.play("popped")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "popped":
		queue_free()

func _on_ScoreSoundTimer_timeout():
	score_sfx.play()
