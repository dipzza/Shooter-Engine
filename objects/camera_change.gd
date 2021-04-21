extends Area2D

export(Vector2) var left_top_limit
export(Vector2) var right_bottom_limit
export(float) var ahead_left
export(float) var ahead_right
export(float) var ahead_top
export(float) var ahead_bottom

signal camera_change(left_top_limit, right_bottom_limit, ahead_left, ahead_right, ahead_top, ahead_bottom)

func _on_ChangeCamera_body_entered(_body):
	get_node("../Player").change_camera(left_top_limit, 
	right_bottom_limit, ahead_left, ahead_right, ahead_top, ahead_bottom)
