extends Area2D

#var FadingTeleport = preload("res://actors/player/fading_sprite.tscn")
#var aim_input = Vector2.ZERO
#
#func _on_TeleportArea_body_entered(body):
#	modulate = Color(0.5, 0.15, 0)
#
#
#func _on_TeleportArea_body_exited(body):
#	modulate = Color(0, 0.3, 0.5)
#
#func _physics_process(delta):
#	# Tp guide
#	if Input.is_action_just_pressed("teleport") and visible:
#		if get_overlapping_bodies().empty():
#			var f = FadingTeleport.instance()
#			f.global_position = get_parent().global_position
#			get_tree().get_root().add_child(f)
#			get_parent().global_position = global_position
#			get_parent().get_node("AnimationPlayer").play("tp")
#
#	get_aim_input()
#
#	if aim_input == Vector2.ZERO:
#		visible = false
#	else:
#		visible = true
#		position = aim_input * get_parent().tp_distance
#		$Sprite.rotation = get_parent().get_node("Sprite").rotation
#
#func get_aim_input():
#	aim_input.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
#	aim_input.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
#	aim_input = aim_input.normalized()
