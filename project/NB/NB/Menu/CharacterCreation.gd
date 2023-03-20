extends Node2D

var hero_name = ""
var emp = 2
var hon = 2
var det = 2
var points = 3

var selected_menu = 0

func change_menu_color():
	$Emp.color = Color("#666389")
	$Hon.color = Color("#666389")
	$Det.color = Color("#666389")
	$Continue.color = Color("#666389")
	$Esc.color = Color("#666389")
	
	match selected_menu:
		0:
			$Emp.color = Color.gray
		1:
			$Hon.color = Color.gray
		2:
			$Det.color = Color.gray
		3:
			$Continue.color = Color.gray
		4:
			$Esc.color = Color.gray

func _ready():
	change_menu_color()
	
func _input(event):
	if Input.is_action_just_pressed("test"):
		test_function()
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 5
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
				if points > 0:
					emp += 1
			1:
				if points > 0:
					hon += 1
			2:
				if points > 0:
					det += 1
			3:
				if points == 0 and validate_name(hero_name):
					get_tree().change_scene("res://Scenes/Main.tscn")
			4:
				get_tree().change_scene("res://Scenes/StartScreen.tscn")
	elif Input.is_action_just_pressed("esc"):
		match selected_menu:
			0:
				if emp > 0:
					emp -= 1
			1:
				if hon > 0:
					hon -= 1
			2:
				if det > 0:
					det -= 1
	points = 9 - emp - hon - det
	$Emp/Label.text = "Эмпатия: " + str(emp)
	$Hon/Label.text = "Честность: " + str(hon)
	$Det/Label.text = "Решимость: " + str(det)
	$Points.text = "очков не распределено: " + str(points)


func _on_LineEdit_text_entered(new_text):
	hero_name = $Nam.text
	$Nam.release_focus()

func validate_name(name):
	if len(name) > 12 or len(name) == 0:
		return false
	else:
		return true

func test_function():
	var file = File.new()
	var path = "res://test.txt"
	var text = ""
	
	if file.open(path, file.WRITE) == OK:
		text = "qwerty"
		text = text + " : " + str(validate_name(text))
		file.store_line(text)
		text = "qwertyйцукенйцукен"
		text = text + " : " + str(validate_name(text))
		file.store_line(text)
		text = ""
		text = text + " : " + str(validate_name(text))
		file.store_line(text)
		file.close()
