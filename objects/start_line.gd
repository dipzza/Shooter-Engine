extends Area2D


signal time_update

onready var time = 0


func _ready():
	set_process(false)
	emit_signal("time_update", "00 : 00 : 00")


func _process(delta):
	time += delta
	emit_signal("time_update", get_time_str())


func _on_StartLine_body_entered(body):
	if body.is_in_group("player"):
		time = 0
		set_process(true)


func _on_FinishLine_body_entered(body):
	if body.is_in_group("player"):
		set_process(false)
		emit_signal("time_update", "Finished\n" + get_time_str())


func get_time_str():
	var mseconds = fmod(time, 1) * 100
	var seconds = fmod(time,60)
	var minutes = fmod(time, 3600) / 60
	return "%02d : %02d : %02d" % [minutes, seconds, mseconds]
