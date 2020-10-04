extends Node2D

const PinScene = preload("res://Wheel/Pin.tscn")

const MIN_PLAYER_DIST = 13
const ROPE_COLOR = Color("#222034")

onready var player_body = $PlayerBody
onready var pin_joint = $PinJoint
onready var starting_pin = $Pin
onready var current_pin = null

onready var dash_particles = $PlayerBody/DashParticles
onready var dash_stop_timer = $DashStopTimer
onready var dashing = false
onready var layers_anim_player = $LayersAnimation

export (NodePath) var bottom_bound = ""
onready var bottom_map_pos = null
onready var game_over = false

func _ready():
	var bottom = get_node_or_null(bottom_bound)
	if bottom != null:
		bottom_map_pos = bottom.global_position

func _draw():
	if current_pin != null:
		var from = player_body.global_position - position
		var to = current_pin.global_position - position
		draw_line(from, to, ROPE_COLOR, 2)

func _process(_delta):
	update()

func _physics_process(_delta):
	if game_over:
		return
	
	if player_body.linear_velocity.length() >= Globals.MIN_DASH_SPEED:
		dash_particles.emitting = true
		layers_anim_player.play("dashing")
		dash_stop_timer.stop()
		dashing = true
	else:
		# Add a bit of delay before the player has stopped dashing
		if dash_stop_timer.is_stopped():
			dash_stop_timer.start()
	
	# Controls
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		if mouse_pos.distance_to(player_body.global_position) > MIN_PLAYER_DIST:
			# Look for the first wheel that was clicked and add a pin to it
			for wheel in get_tree().get_nodes_in_group("Wheels"):
				if mouse_pos.distance_to(wheel.global_position) <= wheel.get_radius():
					set_pin_at(mouse_pos, wheel)
					break
	
	if Input.is_action_just_released("left_click"):
		release_pin()
	
	# Map bound checks
	if player_body.global_position.y >= bottom_map_pos.y:
		# Game over
		game_over = true
		dash_particles.emitting = false
		player_body.mode = RigidBody2D.MODE_STATIC
		player_body.collision_layer = 0
		player_body.collision_mask = 0
		hide()
		get_parent().game_over()

func set_pin_at(pos: Vector2, wheel):
	player_body.gravity_scale = 9
	
	# Create a new pin object
	var pin = PinScene.instance()
	wheel.add_child(pin)
	pin.global_position = pos
	current_pin = pin
	
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
	current_pin = null

func is_dashing() -> bool:
	return dashing

func knockback(force: Vector2):
	player_body.apply_central_impulse(force)

func _on_DashStopTimer_timeout():
	dashing = false
	dash_particles.emitting = false
	layers_anim_player.play("normal")
