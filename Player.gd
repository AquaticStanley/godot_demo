extends Spatial

const MOVE_SPEED = 0.01
const CAMERA_SPEED = 0.5

var enterable_obj = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_desired_movement():
	var x_mod = 0
	var z_mod = 0
	if Input.is_action_pressed("left_move_up"):
		z_mod = -1
	elif Input.is_action_pressed("left_move_down"):
		z_mod = 1
		
	if Input.is_action_pressed("left_move_left"):
		x_mod = -1
	elif Input.is_action_pressed("left_move_right"):
		x_mod = 1
		
	var x_mod_p = x_mod * cos(2*PI-rotation.y) - z_mod * sin(2*PI-rotation.y)
	var z_mod_p = x_mod * sin(2*PI-rotation.y) + z_mod * cos(2*PI-rotation.y)
	
	return Vector3(x_mod_p, 0, z_mod_p).normalized()*MOVE_SPEED

func _process(delta):
	if Input.is_action_just_pressed("camera_toggle"):
		if $InteriorCamera.current:
			$GeneralCamera.current = true
		else:
			$InteriorCamera.current = true
			
	if Input.is_action_just_pressed("interact"):
		if enterable_obj:
			enterable_obj.enter_nested_scene(self)
			
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= Vector3(0, CAMERA_SPEED, 0)
	elif Input.is_action_pressed("ui_right"):
		rotation_degrees += Vector3(0, CAMERA_SPEED, 0)

func on_enter_doorway(enterable, other_body):
	print('entering doorway')
	if other_body == self:
		enterable_obj = enterable

func on_exit_doorway(enterable, other_body):
	print('exiting doorway')
	if other_body == self:
		enterable_obj = null
