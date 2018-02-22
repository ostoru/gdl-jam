extends RigidBody

func _ready():
	set_process_input(true)
	pass


func _input(event):
	if event is InputEventMouseMotion:
		pass

var offset_distance = 0
func _physics_process(delta):
	var yaw_offset = Vector3()
	if Input.is_action_pressed("move_left"):
		yaw_offset.x = 1
		offset_distance += .01
	elif Input.is_action_pressed("move_right"):
		yaw_offset.x = -1
		offset_distance += .01
	else:
		offset_distance -= .01
	if Input.is_action_pressed("move_forward"):
		yaw_offset.z = 1
		offset_distance += .01
	elif Input.is_action_pressed("move_backwards"):
		yaw_offset.z = -1
		offset_distance += .01
	else:
		offset_distance -= .01
	offset_distance = max(.5,min(.1,offset_distance))
	yaw_offset = yaw_offset.normalized()
	$yaw.set_translation(($yaw.get_translation() - yaw_offset) * offset_distance)

func _integrate_forces(state):
	$yaw.get_global_transform().origin - $".".get_global_transform().origin