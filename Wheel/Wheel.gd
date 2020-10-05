extends Node2D

onready var area = $Area2D

export (bool) var interactable = false
onready var PinScene = null
onready var can_click = false

# In degrees
export (int) var rotation_speed = 15

func _ready():
	if interactable:
		PinScene = load("res://Wheel/Pin.tscn")

func _process(delta):
	if can_click:
		if Input.is_action_just_pressed("left_click"):
			var pos = get_global_mouse_position()
			if pos.distance_to(global_position) <= get_radius():
				# Create a new pin object
				var pin = PinScene.instance()
				add_child(pin)
				pin.global_position = pos
				SoundHandler.pin_create_sfx.play()

func _physics_process(delta):
	rotation_degrees += rotation_speed * delta

func get_radius():
	return area.get_child(0).shape.radius
