extends KinematicBody2D

# Player movement speed
export var speed = 75

var locked = false

var hero_name
var emp
var hon
var det
var quests

var save_file = File.new()
var save_path = "res://save_file.txt"

var npc_group = "NPCs"
var interact = null
var current_npc = null

#Raycast for checking collisions wwith NPCs
var raycast = null
var raycast_length = 50
var raycast_collision_mask = 1
var last_direction = null


func _ready():
	raycast = RayCast2D.new()
	add_child(raycast)
	raycast.cast_to = Vector2(0, raycast_length)
	raycast.collision_mask = raycast_collision_mask
	raycast.enabled = true
	interact = get_node("Interact")
	if save_file.open(save_path, File.READ) == OK:
		hero_name = save_file.get_var()
		emp = save_file.get_var()
		hon = save_file.get_var()
		det = save_file.get_var()
		position.x = save_file.get_var()
		position.y = save_file.get_var()
		quests = save_file.get_var()

func _physics_process(delta):
	if Input.get_action_strength("interact") and not locked and current_npc != null:
		locked = true
		start_dialogue(current_npc)
		
	if not locked:
		if Input.is_action_just_pressed("esc"):
			if save_file.open(save_path, File.WRITE) == OK:
				save_file.store_var(hero_name)
				save_file.store_var(emp)
				save_file.store_var(hon)
				save_file.store_var(det)
				save_file.store_var(position.x)
				save_file.store_var(position.y)
				save_file.store_var(quests)
				save_file.close()
			get_tree().change_scene("res://Scenes/StartScreen.tscn")
		
		# Get player input
		var direction: Vector2
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		# If input is digital, normalize it for diagonal movement
		if abs(direction.x) == 1 and abs(direction.y) == 1:
			direction = direction.normalized()
		
		# Apply movement
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

func start_dialogue(npc):
	locked = false
