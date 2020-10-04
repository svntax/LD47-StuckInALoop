extends Node2D

onready var animation_player = $AnimationPlayer
onready var intro_timer = $IntroTimer

onready var cutscene_finished = false

func _ready():
	animation_player.play("intro")
	intro_timer.start()

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		# Skip intro cutscene
		intro_timer.stop()
		cutscene_finished = true
		animation_player.stop()
		animation_player.play("normal")

func _on_IntroTimer_timeout():
	animation_player.play("intro_transition")
	animation_player.queue("normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	cutscene_finished = true
