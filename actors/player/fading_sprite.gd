extends Sprite

func _init():
	var dup_mat = self.material.duplicate()
	self.material = dup_mat

func _ready():
	$AnimationPlayer.play("tp_out")
	yield(get_node("AnimationPlayer"), "animation_finished")
	queue_free()
