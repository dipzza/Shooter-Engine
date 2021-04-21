extends Area2D

export var speed = 500

func _on_SpeedRing_body_entered(body):
	if body.is_in_group("player"):
		body.boost(Vector2(speed, 0).rotated(rotation))
