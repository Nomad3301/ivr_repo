extends KinematicBody2D

# Player movement speed
export var speed = 75

var locked = false
var last_direction = null

var npc_group = "NPCs"
var interact = null
var current_npc = null

#Raycast for checking collisions wwith NPCs
var raycast = null
var raycast_length = 50
var raycast_collision_mask = 1


func _ready():
	raycast = RayCast2D.new()
	add_child(raycast)
	raycast.cast_to = Vector2(0, raycast_length)
	raycast.collision_mask = raycast_collision_mask
	raycast.enabled = true
	interact = get_node("Interact")

func _physics_process(delta):
	if Input.get_action_strength("interact") and not locked and current_npc != null:
		locked = true
		start_dialogue(current_npc)
		
	if not locked:
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
	pass
