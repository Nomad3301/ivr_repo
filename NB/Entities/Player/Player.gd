extends KinematicBody2D

export var speed = 75

export var locked = false

var hero_name
export var emp = 0
var emp_change
export var hon = 0
var hon_change
export var det = 0
var det_change
export var quests = "0"

var save_file = File.new()
var save_path = "res://save_file.txt"

var npc_group = "NPCs"
var interact = null
var current_npc = ""
signal start_dialogue(npc_name)

#Raycast для проверки коллизий
var raycast = null
var raycast_length = 50
var raycast_collision_mask = 1
var last_direction = null

#Обработка всего изменения информации в результате диалогов
func change(ch):
	if ch == "esc":
		get_parent().get_node("CanvasLayer").visible = false
		locked = false
		current_npc = ""
	elif ch[0] == "q":
		quests = ch[2]
	else:
		match ch[0]:
			"e":
				emp_change += int(ch.substr(1))
			"h":
				hon_change += int(ch.substr(1))
			"d":
				det_change += int(ch.substr(1))
	

#Вызывается при загрузке
func _ready():
	get_parent().get_node("CanvasLayer").connect("change", self, "change")
	get_parent().get_node("CanvasLayer").visible = false
	
	
	raycast = RayCast2D.new()
	add_child(raycast)
	raycast.cast_to = Vector2(0, raycast_length)
	raycast.collision_mask = raycast_collision_mask
	raycast.enabled = true
	interact = get_node("Interact")
	if save_file.open(save_path, File.READ) == OK:
		hero_name = save_file.get_var()
		emp = save_file.get_var()
		emp_change = save_file.get_var()
		hon = save_file.get_var()
		hon_change = save_file.get_var()
		det = save_file.get_var()
		det_change = save_file.get_var()
		position.x = save_file.get_var()
		position.y = save_file.get_var()
		quests = save_file.get_var()
		save_file.close()

#Функция для обработки ввода
func _physics_process(delta):
	if Input.is_action_just_pressed("char"):
		if not get_parent().get_node("CanvasLayer").visible:
			locked = not locked
			get_parent().get_node("CanvasLayer2").visible = not get_parent().get_node("CanvasLayer2").visible
	
	if Input.is_action_just_pressed("interact") and not locked and current_npc != "":
		locked = true
		start_dialogue(current_npc)
		
	if not locked:
			
		
		if Input.is_action_just_pressed("esc"):
			if save_file.open(save_path, File.WRITE) == OK:
				save_file.store_var(hero_name)
				save_file.store_var(emp)
				save_file.store_var(emp_change)
				save_file.store_var(hon)
				save_file.store_var(hon_change)
				save_file.store_var(det)
				save_file.store_var(det_change)
				save_file.store_var(position.x)
				save_file.store_var(position.y)
				save_file.store_var(quests)
				save_file.close()
			get_tree().change_scene("res://Scenes/StartScreen.tscn")
		
		var direction: Vector2
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()

		var movement = speed * direction
		last_direction = direction
		move_and_slide(movement)
		
		raycast.global_position = global_position
		if last_direction != Vector2.ZERO:
			raycast.cast_to = last_direction * 20
		if raycast.is_colliding() and raycast.get_collider().is_in_group(npc_group):
			current_npc = raycast.get_collider().get("name")
			interact.visible = true
		else:
			interact.visible = false
			current_npc = ""

#функция для начала диалога с нпс
func start_dialogue(npc):
	get_parent().get_node("CanvasLayer").visible = true
	emit_signal("start_dialogue", npc)
	#locked = false
