extends StaticBody2D

func _ready():
	get_parent().connect('exploding', self, '_on_Brick_exploding')

func hit(_dmg):
	pass

func _on_Brick_exploding():
	queue_free()
