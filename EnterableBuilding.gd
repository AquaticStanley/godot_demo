extends Spatial

enum Direction {North, South, East, West}

export (Direction) var entrance

signal on_enter_doorway
signal on_exit_doorway

func rotation_from_direction(direction):
	var rotation_degrees = 0
	if entrance == Direction.East:
		rotation_degrees = 90
	elif entrance == Direction.North:
		rotation_degrees = 180
	elif entrance == Direction.West:
		rotation_degrees = 270
	return rotation_degrees

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set entrance to the correct position
	var x_offset = 0
	var z_offset = 0
	if entrance == Direction.East:
		x_offset += scale.x + 0.01
	elif entrance == Direction.West:
		x_offset -= scale.x + 0.01
	
	if entrance == Direction.North:
		z_offset -= scale.z + 0.01
	elif entrance == Direction.South:
		z_offset += scale.z + 0.01

	# Move the Entrance Area itself to the proper side
	$EntranceArea.translate(Vector3(x_offset, 0, z_offset))
	$EntranceArea.rotation_degrees = Vector3(0, rotation_from_direction(entrance), 0)

# This will give the player object to the nested scene within
func enter_nested_scene(player):
	# Set interior camera
	player.get_node("InteriorCamera").current = true
	
	# Rotate all player to entrance side
	var rotation_degrees = rotation_from_direction(entrance)
	player.rotation_degrees = Vector3(0, rotation_degrees, 0)
	
	# Replace walls except the entrance side with static objects
	
	# Replace entrance side with static object that has space for the door
	
	# Make entrance side invisible but with collision enabled
	
	# Shrink the player sprite to make inside seem slightly bigger

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func on_player_interact(player):
#	# Check if the player is within the doorway
#	if $EntranceArea.overlaps_body(player):
#		enter_nested_scene(player)


func _on_EntranceArea_body_entered(body):
	emit_signal("on_enter_doorway", self, body)
	
func _on_EntranceArea_body_exited(body):
	emit_signal("on_exit_doorway", self, body)
