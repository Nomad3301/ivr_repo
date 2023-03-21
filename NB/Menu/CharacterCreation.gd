extends Node2D

var hero_name = ""
var emp = 2
var emp_change = 0
var hon = 2
var hon_change = 0
var det = 2
var det_change = 0
var points = 3
var default_x = 157
var default_y = 95
var default_quests = "0"

var save_file = File.new()
var save_path = "res://save_file.txt"

var selected_menu = 0

#листание меню
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
#вызывается при загрузке
func _ready():
	print(OS.get_user_data_dir())
	change_menu_color()
	
#обработка всего ввода
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
			selected_menu = 4
		change_menu_color()
	elif Input.is_action_just_pressed("interact"):
		match selected_menu:
			0:
				if points > 0 and emp < 5:
					emp += 1
			1:
				if points > 0 and hon < 5:
					hon += 1
			2:
				if points > 0 and det < 5:
					det += 1
			3:
				if points == 0 and validate_name(hero_name):
					if save_file.open(save_path, File.WRITE) == OK:
						save_file.store_var(hero_name)
						save_file.store_var(emp)
						save_file.store_var(emp_change)
						save_file.store_var(hon)
						save_file.store_var(hon_change)
						save_file.store_var(det)
						save_file.store_var(det_change)
						save_file.store_var(default_x)
						save_file.store_var(default_y)
						save_file.store_var(default_quests)
						save_file.close()
					get_tree().change_scene("res://Scenes/Main.tscn")
			4:
				get_tree().change_scene("res://Scenes/StartScreen.tscn")
	elif Input.is_action_just_pressed("esc"):
		match selected_menu:
			0:
				if emp > 1:
					emp -= 1
			1:
				if hon > 1:
					hon -= 1
			2:
				if det > 1:
					det -= 1
	points = 9 - emp - hon - det
	$Emp/Label.text = "Эмпатия: " + str(emp)
	$Hon/Label.text = "Честность: " + str(hon)
	$Det/Label.text = "Решимость: " + str(det)
	$Points.text = "очков не распределено: " + str(points)

#сохранять имя персонажа после ввода
func _on_LineEdit_text_entered(new_text):
	hero_name = $Nam.text
	$Nam.release_focus()

#проверка допустимости имени
func validate_name(name):
	if len(name) > 12 or len(name) == 0:
		return false
	else:
		return true

#тестирование функции
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
