extends CanvasLayer

var selected_menu = 2
var npc
var strings = {}
var answer_list = ["", "", ""]

signal change(ch)

#функция для листания меню
func change_menu_color():
	$ColorRect/ColorRect2.color = Color("#666389")
	$ColorRect/ColorRect3.color = Color("#666389")
	$ColorRect/ColorRect4.color = Color("#666389")
	
	match selected_menu:
		0:
			$ColorRect/ColorRect2.color = Color.gray
		1:
			$ColorRect/ColorRect3.color = Color.gray
		2:
			$ColorRect/ColorRect4.color = Color.gray

#функция для обработки всего ввода
func _input(event):
	if get_parent().get_node("Player").locked and self.visible:
		if Input.is_action_just_pressed("test"):
			$Label.visible = not $Label.visible
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
			answer(selected_menu)

#функция загружающая информацию о диалоге
func show_dialogue(npc_name):
	npc = npc_name
	var text_path = "res://Text/"
	var dialogue_strings = File.new()
	dialogue_strings.open(str(text_path + npc + ".txt"), File.READ)
	strings = {}
	while not dialogue_strings.eof_reached():
		var line = dialogue_strings.get_line()
		strings[line.substr(0, 3)] = line
	show_string("000")	

#функция для работы с диалоговыми строчками
func show_string(id):
	$Label.text = id
	var curr = strings[id]
	if id == "999":
		$Label.text = "999"
		$ColorRect/ColorRect2/Label.text = ""
		$ColorRect/ColorRect3/Label.text = ""
		$ColorRect/ColorRect4/Label.text = ""
		emit_signal("change", "esc")
	elif curr[4] == "с" or curr[4] == "h":
		emit_signal("change", curr.substr(10, 3))
		$Label.text = curr.substr(6, 3)
		show_string(curr.substr(6, 3))
	elif curr[4] == "a":
		show_string(curr.substr(6, 3))
	elif curr[4] == "s":
		$Label.text = $Label.text + curr.substr(8, 3) + curr.substr(12, 3) + curr.substr(16, 3)
		$ColorRect/ColorRect/RichTextLabel.text = curr.substr(26)
		$ColorRect/ColorRect2/Label.text = ""
		$ColorRect/ColorRect3/Label.text = ""
		$ColorRect/ColorRect4/Label.text = ""
		answer_list = [curr.substr(8, 3), curr.substr(12, 3), curr.substr(16, 3)]
		var matches = true
		matches = matche(strings[curr.substr(8, 3)].substr(10, 15))
		if matches:
			$ColorRect/ColorRect2/Label.text = strings[curr.substr(8, 3)].substr(26)
		if int(curr[6]) > 1:
			matches = matche(strings[curr.substr(12, 3)].substr(10, 15))
			if matches:
				$ColorRect/ColorRect3/Label.text = strings[curr.substr(12, 3)].substr(26)
		if int(curr[6]) > 2:
			matches = matche(strings[curr.substr(16, 3)].substr(10, 15))
			if matches:
				$ColorRect/ColorRect4/Label.text = strings[curr.substr(16, 3)].substr(26)
	
		
#функция для выбора ответа в диалоге
func answer(n):
	var can = false
	match n:
		0:
			if $ColorRect/ColorRect2/Label.text != "":
				can = true
		1:
			if $ColorRect/ColorRect3/Label.text != "":
				can = true
		2:
			if $ColorRect/ColorRect4/Label.text != "":
				can = true
	if can:
		show_string(answer_list[n])

#вызывается при загрузке
func _ready():
	get_parent().get_node("Player").connect("start_dialogue", self, "show_dialogue")
	$Label.visible = false

#проверка доступности варианта ответа
func matche(cond):
	var p = get_parent().get_node("Player")
	if p.emp>int(cond[1]) and p.emp<int(cond[2]) and p.hon>int(cond[5]) and p.hon<int(cond[6]) and p.det>int(cond[9]) and p.det<int(cond[10]):
		if cond[13] == "9":
			return true
		else:
			if p.quests != cond[14]:
				return false
			else:
				return true
	else:
		return false
