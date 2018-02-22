extends RigidBody
export var active = false
func _ready():
	if active:
		set_process_input(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

var mouse_relative_pos = Vector2()
func _input(event):
	if event is InputEventMouseMotion:
		mouse_relative_pos += event.relative

var offset_distance = 0
var sensitivity = .3
func _physics_process(delta):
	if active:
		$yaw.rotate_y( -mouse_relative_pos.x * sensitivity * delta)
		$yaw/pitch.rotate_x(mouse_relative_pos.y * sensitivity * delta)
		mouse_relative_pos = Vector2()
		
		var yaw_offset = Vector3()
		if Input.is_action_pressed("move_left"):
			yaw_offset.x = 1
			offset_distance += .001
		elif Input.is_action_pressed("move_right"):
			yaw_offset.x = -1
			offset_distance += .001
		else:
			offset_distance -= .0004
		if Input.is_action_pressed("move_forward"):
			yaw_offset.z = 1
			offset_distance += .001
		elif Input.is_action_pressed("move_backwards"):
			yaw_offset.z = -1
			offset_distance += .001
		else:
			offset_distance -= .0004
		offset_distance = max(.5,min(.1,offset_distance))
		yaw_offset = yaw_offset.normalized()
		$yaw/pitch.set_translation(($yaw.get_translation() - yaw_offset) * offset_distance)
		
		var test = ($".".get_global_transform().origin - $yaw/pitch.get_global_transform().origin).normalized() * delta * offset_distance * 1000
		test.y = 0
		linear_velocity = test
		print(linear_velocity)
