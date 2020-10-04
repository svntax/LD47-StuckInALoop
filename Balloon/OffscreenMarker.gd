extends Node2D

# Based on this tutorial: https://www.youtube.com/watch?v=Sw9Iiejkae4

onready var arrow = $Arrow
onready var icon = $Arrow/Icon

func _process(_delta):
	# Make sure the root node is always at 0 rotation because sometimes
	# its parent node can rotate
	global_rotation = 0

	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	
	set_marker_position(Rect2(top_left, size))
	set_marker_rotation()

func set_marker_position(bounds: Rect2):
	arrow.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
	arrow.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)
	
	if bounds.has_point(global_position):
		arrow.hide()
	else:
		arrow.show()

func set_marker_rotation():
	var angle = (global_position - arrow.global_position).angle()
	arrow.global_rotation = angle
	icon.global_rotation = 0

func set_icon_texture(texture):
	if texture != null:
		icon.set_texture(texture)
