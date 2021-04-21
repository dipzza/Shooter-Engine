extends StaticBody2D

export var max_health = 4
export var glow_factor = 0.4
var health = max_health

signal exploding

func hit(damage_points):
	health -= damage_points
	apply_glow()
	
	if health <= 0:
		emit_signal("exploding")
		$AnimatedSprite.play("Explode")
		$CollisionShape2D.set_deferred("disabled", true)
		yield($AnimatedSprite, "animation_finished")
		$RespawnTimer.start()


func _on_Timer_timeout():
	$RespawnTimer.stop()
	health = max_health
	apply_glow()
	
	$AnimationPlayer.play_backwards("explode")
	yield($AnimationPlayer, "animation_finished")
	
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite.play("dark")

func apply_glow():
	var glow = glow_factor * (1 - float(health) / float(max_health))
	modulate = Color(1 + glow, 1, 1, 1 )
