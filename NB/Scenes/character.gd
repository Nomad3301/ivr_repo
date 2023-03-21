extends CanvasLayer

var selected_menu = 0
var state_path = "res://Text/Quests.txt"
var states = File.new()
var states_dict = []

#выполняется при загрузке
func _ready():
	change_menu_color()
	states.open(state_path, File.READ)
	while not states.eof_reached():
		var line = states.get_line()
		states_dict.append(line)

#листание меню
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

#обработка всего вводы
func _input(event):
	var p = get_parent().get_node("Player")
	$ColorRect/ColorRect/RichTextLabel.text = states_dict[int(p.quests)]
	$ColorRect/ColorRect2/Label.text = "эмпатия: " + str(p.emp)
	if abs(p.emp_change) >= 3:
		$ColorRect/ColorRect2/Label.text+="(!)"
	$ColorRect/ColorRect3/Label.text = "честность: " + str(p.hon)
	if abs(p.hon_change) >= 3:
		$ColorRect/ColorRect3/Label.text+="(!)"
	$ColorRect/ColorRect4/Label.text = "решительность: " + str(p.det)
	if abs(p.det_change) >= 3:
		$ColorRect/ColorRect4/Label.text+="(!)"
	if p.locked and self.visible:
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 3
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu -= 1
			else:
				selected_menu = 2
			change_menu_color()
		if Input.is_action_just_pressed("interact"):
			match selected_menu:
				0:
					if abs(p.emp_change) >= 3:
						p.emp += p.emp_change / abs(p.emp_change)
						p.emp_change = 0
				1:
					if abs(p.hon_change) >= 3:
						p.hon += p.hon_change / abs(p.hon_change)
						p.hon_change = 0
				2:
					if abs(p.det_change) >= 3:
						p.det += p.det_change / abs(p.det_change)
						p.det_change = 0
