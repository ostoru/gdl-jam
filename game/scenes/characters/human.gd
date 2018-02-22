extends RigidBody
export var active = false
func _ready():
	if active:
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
	if active:
		set_translation($".".get_global_transform().origin + (($".".get_global_transform().origin - $yaw/pitch.get_global_transform().origin).normalized() * offset_distance))
