extends Node2D

onready var score01 = $Grid/Stage01/Score
onready var score02 = $Grid/Stage02/Score
onready var stage02_label = $Grid/Stage02/Name
onready var button02 = $Grid/Stage02/Button02
onready var animation_player = $AnimationPlayer
onready var locked_rect = $LockedRect

func _ready():
	score01.set_text("High Score: " + str(Globals.high_scores[0]))
	if Globals.high_scores[0] < 10:
		stage02_label.set_text("LOCKED: Get a score")
		score02.set_text("of 10 in Stage 1")
		animation_player.play("locked")
		button02.disabled = true
		locked_rect.show()
	else:
		stage02_label.set_text("STAGE 2")
		score02.set_text("High Score: " + str(Globals.high_scores[1]))
		animation_player.play("unlocked")
		locked_rect.hide()

func _on_Button01_pressed():
	SoundHandler.select_sfx.play()
	Globals.current_map = 0
	get_tree().change_scene("res://Stages/Stage01.tscn")

func _on_Button02_pressed():
	SoundHandler.select_sfx.play()
	Globals.current_map = 1
	get_tree().change_scene("res://Stages/Stage02.tscn")

func _on_Back_pressed():
	SoundHandler.hit_sfx.play()
	get_tree().change_scene("res://Main.tscn")
