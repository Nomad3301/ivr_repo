extends Node2D

var selected_menu = 0

var save_file = File.new()
var save_path = "res://save_file.txt"

func change_menu_color():
	$NewGame.color = Color("#666389")
	$LoadGame.color = Color("#666389")
	$Exit.color = Color("#666389")
	
	match selected_menu:
		0:
			$NewGame.color = Color.gray
		1:
			$LoadGame.color = Color.gray
		2:
			$Exit.color = Color.gray

func _ready():
	change_menu_color()
	
func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu -= 1
		else:
			selected_menu = 2
		change_menu_color()
	elif Input.is_action_just_pressed("interact"):
		match selected_menu:
			0:
				get_tree().change_scene("res://Scenes/CharacterCreation.tscn")
			1:
				if save_file.open(save_path, File.READ) == OK:
					get_tree().change_scene("res://Scenes/Main.tscn")
			2:
				get_tree().quit()
