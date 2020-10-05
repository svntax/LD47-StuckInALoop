extends Node2D

onready var animation_player = $AnimationPlayer
onready var intro_timer = $IntroTimer
onready var wheel = $Wheel
onready var buttons = $Buttons
onready var buttons_background = $ButtonsBg
onready var hit_sfx = $HitSound
onready var select_sfx = $SelectSound

onready var cutscene_finished = false

func _ready():
	animation_player.play("intro")
	intro_timer.start()
	wheel.rotation_speed = 0
	wheel.rotation = 0
	buttons.hide()
	buttons_background.hide()

func _process(_delta):
	if Input.is_action_just_pressed("left_click") and !cutscene_finished:
		# Skip intro cutscene
		intro_timer.stop()
		animation_player.stop()
		animation_player.play("normal")
		wheel.rotation_speed = 15
		buttons.show()
		buttons_background.show()
		cutscene_finished = true
		hit_sfx.play()

func _on_IntroTimer_timeout():
	animation_player.play("intro_transition")
	animation_player.queue("normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "intro_transition":
		cutscene_finished = true
		hit_sfx.play()
		#wheel.rotation_speed = 15

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "normal":
		wheel.rotation_speed = 15
		buttons.show()
		buttons_background.show()

func _on_Play_pressed():
	if not cutscene_finished:
		return
	
	select_sfx.play()
	get_tree().change_scene("res://Stages/Stage01.tscn")

func _on_Exit_pressed():
	if not cutscene_finished:
		return
	
	get_tree().quit()
