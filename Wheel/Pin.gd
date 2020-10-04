extends StaticBody2D

export (bool) var permanent = false
onready var broken = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		if !broken and mouse_pos.distance_to(global_position) <= 8:
			break_pin()

func break_pin():
	if permanent:
		return
	
	if broken:
		return
	broken = true
	
	queue_free()