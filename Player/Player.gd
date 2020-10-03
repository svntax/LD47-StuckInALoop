extends Node2D

onready var player_body = $PlayerBody
onready var pin_joint = $PinJoint
onready var pin = $Pin

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		pin_joint.global_position = get_global_mouse_position()
		pin_joint.set_node_a(pin.get_path())
		player_body.gravity_scale = 10
#		if pin_joint.global_position.x < player_body.global_position.x:
#			player_body.apply_impulse(Vector2.ZERO, Vector2(-128, 0))
#		else:
#			player_body.apply_impulse(Vector2.ZERO, Vector2(128, 0))
	if Input.is_action_just_released("left_click"):
		pin_joint.set_node_a("")
		player_body.gravity_scale = 4
