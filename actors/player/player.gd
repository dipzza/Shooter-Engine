extends KinematicBody2D

export var max_speed = 1000
export var accel = 2700
export var friction = 100

export(float) var bounce_treshold = 0.3
export(float) var bounce_factor = 0.7

var vel = Vector2.ZERO
var input = Vector2.ZERO
var aim_input = Vector2.ZERO
var was_on_wall = false

var Bullet = preload("res://objects/bullet.tscn")
var recharge_time = 0
export(float) var shoot_freq = 0.1
export(int) var tp_distance = 384

func _physics_process(delta):
	get_input()
	
	# Calculate velocity
	if input == Vector2.ZERO:
		vel = vel.linear_interpolate(Vector2.ZERO, 2 * delta)
	else:
		$Sprite.rotation = input.angle()
		var extra_vel = input * accel * delta
		vel += extra_vel
		if vel.length() > max_speed:
			vel = vel.move_toward(vel.normalized() * max_speed, friction * delta + extra_vel.length())
	
	# Move and bounce / slide
	if vel.length() > max_speed * bounce_treshold && !was_on_wall:
		var collision = move_and_collide(vel * delta)
		if collision:
			vel = vel.bounce(collision.normal) * bounce_factor
	else:
		vel = move_and_slide(vel, Vector2.ZERO)
	
	was_on_wall = is_on_wall()


func _process(delta):
	# Shooting
	recharge_time -= delta
	
	if input.length() != 0 and recharge_time <= 0:
		shoot()
		recharge_time = shoot_freq

func get_input():
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input = input.normalized()

func shoot():
	var b = Bullet.instance()
	b.start(position + Vector2(50, 0).rotated(input.angle() + PI), input.angle() + PI, max_speed + vel.length() / 5)
	get_parent().add_child(b)
	
func boost(speed):
	vel += speed

func change_camera(left_top_limit, right_bottom_limit, ahead_left, ahead_right, ahead_top, ahead_bottom):
	$Camera2D.change_camera(left_top_limit.x, left_top_limit.y, right_bottom_limit.x, 
	right_bottom_limit.y, ahead_left, ahead_right, ahead_top, ahead_bottom)
