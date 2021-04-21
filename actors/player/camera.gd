extends Camera2D

export var ahead_left = 0
export var ahead_right = 0
export var ahead_top = 0
export var ahead_bottom = 0
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_IN_OUT
const SHIFT_DURATION =  0.8

var facing = Vector2.ZERO
onready var prev_camera_pos = get_camera_position()

func _process(_delta):
	_check_facing()
	prev_camera_pos = get_camera_position()

func _check_facing():
	var new_facing = Vector2(sign(get_camera_position().x - prev_camera_pos.x), sign(get_camera_position().y - prev_camera_pos.y))
	if new_facing.x != 0 && facing.x != new_facing.x:
		facing.x = new_facing.x
		look_ahead(true)
	
	if new_facing.y != 0 && facing.y != new_facing.y:
		facing.y = new_facing.y
		look_ahead(false, true)

func look_ahead(hor=false, vert=false):
	var ahead = Vector2()
	
	ahead.x = ahead_right if facing.x > 0 else ahead_left
	ahead.y = ahead_bottom if facing.y > 0 else ahead_top
	
	if hor:
		var look_offset = get_viewport_rect().size.x * facing.x * ahead.x
		$Tween.interpolate_property(self, "position:x", position.x, look_offset, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
		$Tween.start()
	if vert:
		var look_offset = get_viewport_rect().size.y * facing.y * ahead.y
		$Tween.interpolate_property(self, "position:y", position.y, look_offset, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
		$Tween.start()

func change_camera(left, top, right, bottom, ahead_l, ahead_r, ahead_t, ahead_b):
	var a = get_bottom_margin()
	
	if left != limit_left:
		limit_left = min(global_position.x - get_left_margin(), left)
	if right != limit_right:
		limit_right = max(get_right_margin() + global_position.x, right)
	
	
	$Tween.interpolate_property(self, "limit_left", limit_left, left, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
	$Tween.start()
	$Tween.interpolate_property(self, "limit_right", limit_right, right, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
	$Tween.start()
	$Tween.interpolate_property(self, "limit_top", limit_top, top, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
	$Tween.start()
	$Tween.interpolate_property(self, "limit_bottom", limit_bottom, bottom, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
	$Tween.start()
	
	ahead_l = ahead_l
	ahead_right = ahead_r
	ahead_top = ahead_t
	ahead_bottom = ahead_b
	
	look_ahead(true, true)

func get_camera_center_offset():
	if anchor_mode == ANCHOR_MODE_FIXED_TOP_LEFT:
		return Vector2.ZERO
	elif anchor_mode ==  ANCHOR_MODE_DRAG_CENTER:
		return get_camera_size()/2

func get_camera_size():
	return get_viewport().get_visible_rect().size

func get_left_margin():
	return get_camera_center_offset().x

func get_right_margin():
	return ProjectSettings.get_setting("display/window/size/width") * zoom.x - get_camera_center_offset().x

func get_top_margin():
	return get_camera_center_offset().y

func get_bottom_margin():
	return ProjectSettings.get_setting("display/window/size/height") * zoom.y - get_camera_center_offset().y
