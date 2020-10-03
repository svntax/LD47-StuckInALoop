extends Node2D
class_name Player

const PinScene = preload("res://Wheel/Pin.tscn")

const MIN_PLAYER_DIST = 13

onready var player_body = $PlayerBody
onready var pin_joint = $PinJoint
onready var starting_pin = $Pin

func _physics_process(_delta):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		if mouse_pos.distance_to(player_body.global_position) > MIN_PLAYER_DIST:
			# Look for the first wheel that was clicked and add a pin to it
			for wheel in get_tree().get_nodes_in_group("Wheels"):
				if mouse_pos.distance_to(wheel.global_position) <= wheel.get_radius():
					set_pin_at(mouse_pos, wheel)
					break
#		if pin_joint.global_position.x < player_body.global_position.x:
#			player_body.apply_impulse(Vector2.ZERO, Vector2(-128, 0))
#		else:
#			player_body.apply_impulse(Vector2.ZERO, Vector2(128, 0))
	if Input.is_action_just_released("left_click"):
		release_pin()

func set_pin_at(pos: Vector2, wheel):
	player_body.gravity_scale = 10
	
	# Create a new pin object
	var pin = PinScene.instance()
	wheel.add_child(pin)
	pin.global_position = pos
	
	# Reparent the starting pin and pin joint to the wheel
	var parent = pin_joint.get_parent()
	parent.remove_child(pin_joint)
	wheel.add_child(pin_joint)
	
	var pin_parent = starting_pin.get_parent()
	pin_parent.remove_child(starting_pin)
	wheel.add_child(starting_pin)
	starting_pin.hide()
	
	pin_joint.global_position = pos
	pin_joint.set_node_a(starting_pin.get_path())
	pin_joint.set_node_b(player_body.get_path())

func release_pin():
	pin_joint.set_node_a("")
	player_body.gravity_scale = 4

func knockback(force: Vector2):
	player_body.apply_central_impulse(force)
