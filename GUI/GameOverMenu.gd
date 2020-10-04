extends Control

onready var score_label = $Bg/Score
onready var new_high_score_label = $Bg/NewHighScoreText

onready var active = false

func _ready():
	new_high_score_label.hide()

func _on_Quit_pressed():
	if active:
		get_tree().change_scene("res://Main.tscn")

func _on_Restart_pressed():
	if active:
		get_tree().reload_current_scene()

func set_score(value: int):
	score_label.set_text("Score: " + str(value))

func set_active(flag: bool):
	active = flag

func set_new_high_score_text(flag: bool):
	new_high_score_label.visible = flag
