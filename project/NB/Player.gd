extends KinematicBody2D

signal change_stat(name)

func _ready():
	pass # Replace with function body.

enum { STATE_WALKING, STATE_DIALOGUE, STATE_THINKING }

var state = STATE_WALKING

func Morph():
	pass
	
func Save():
	pass
	
func Spawn(loc):
	pass
