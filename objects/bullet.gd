extends KinematicBody2D

var vel = Vector2()
var collided = false
export var damage = 1
export var exp_slowdown = 0.4

func start(pos, dir, spd):
	position = pos
	rotation = dir
	vel = Vector2(spd, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(vel * delta)
	if collision:
		$AnimatedSprite.scale.x = 0.5
		$AnimatedSprite.scale.y = 0.5
		$AnimatedSprite.play("explosion")
		
		if collision.collider.has_method("hit") && !collided:
			vel = vel * exp_slowdown
			collision.collider.hit(damage)
			collided = true
			
		yield($AnimatedSprite, "animation_finished")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
