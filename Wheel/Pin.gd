extends StaticBody2D

onready var area_detect = $AreaDetect
onready var sprite = $Sprite
onready var particles = $Particles
onready var death_timer = $DeathTimer

export (bool) var permanent = false
onready var broken = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		if !broken and mouse_pos.distance_to(global_position) <= 8:
			SoundHandler.pin_break_sfx.play()
			break_pin()

func break_pin():
	if permanent:
		return
	
	if broken:
		return
	broken = true
	
	sprite.hide()
	collision_mask = 0
	collision_layer = 0
	area_detect.collision_layer = 0
	area_detect.collision_mask = 0
	particles.emitting = true
	death_timer.start()

func _on_AreaDetect_body_entered(body):
	if body.is_in_group("Players"):
		if body.get_parent().is_dashing():
			if !permanent and !broken:
				body.get_parent().pin_break_sfx.play()
			break_pin()
		else:
			body.get_parent().play_hit_sound()


func _on_DeathTimer_timeout():
	queue_free()
