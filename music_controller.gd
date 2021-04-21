extends Node

var music = load("res://assets/music/rush.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_music()

func play_music():
	$AudioPlayer.stream = music
	$AudioPlayer.play()
