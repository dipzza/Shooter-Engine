extends CanvasLayer

func _on_StartLine_time_update(time):
	$Score.set_text(time)
