extends RigidBody
export var third_person = false
func _ready():
	if third_person:
		set_process_input(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$"yaw/pitch/cam base/camera".make_current()
	pass

var mouse_relative_pos = Vector2()
func _input(event):
	if event is InputEventMouseMotion:
		mouse_relative_pos += event.relative

var offset_distance = 0
var speed = 0
func _physics_process(delta):
	if third_person:
		third_person_camera_look (delta)
		third_person_input_handling (delta)
#		offset_distance = max(.5,min(.1,offset_distance))
#		yaw_offset = yaw_offset.normalized()
#		$yaw/pitch.set_translation((-yaw_offset) * offset_distance)
#		if Input.is_action_pressed("run"):
#			speed += 0.1
#		else:
#			speed -= 0.1
#		speed = min(2,max(.7,speed))
#		if speed >= 1:
#			var character_look_difference = $col/person.global_transform.origin - yaw_offset
#			$col/person.look_at(character_look_difference,Vector3(0,1,0))
#		else:
#			$col/person.rotation = $yaw.rotation
#
#		var test = ($yaw/pitch.get_global_transform().origin - $".".get_global_transform().origin).normalized() * delta * offset_distance * 1000
#		test.y = 0
#		linear_velocity = test

var sensitivity = .3
var max_cam_rot = 1.5
var min_cam_rot = -1.5
func third_person_camera_look (delta):
	$yaw.rotate_y( -mouse_relative_pos.x * sensitivity * delta)
	$yaw/pitch.rotate_x(max(-.9,min(.9,-mouse_relative_pos.y * sensitivity * delta)))
	if $yaw/pitch.rotation.x > max_cam_rot:
		$yaw/pitch.rotation.x = max_cam_rot
	elif $yaw/pitch.rotation.x < min_cam_rot:
		$yaw/pitch.rotation.x = min_cam_rot
	mouse_relative_pos = Vector2()

var button = {
	shoot = 0,
	aim = 0,
	jump = 0,
	run = 0,
	left = 0,
	right = 0,
	front = 0,
	back = 0,
	use = 0
}
var moving = false
func third_person_input_handling(delta):
	if Input.is_action_pressed("jump"):
		pass
	else:
		
		if Input.is_action_pressed("aim"):
			pass
		elif Input.is_action_pressed("run"):
			pass
		
#	var yaw_offset = Vector3()
#	var move_anim = $col/person/AnimationPlayer.get_animation("3d move neutral")
#	if Input.is_action_pressed("left"):
#		yaw_offset.x = 1
#		move_anim = $col/person/AnimationPlayer.get_animation("3d move left")
#		moving = true
#	elif Input.is_action_pressed("right"):
#		yaw_offset.x = -1
#		move_anim = $col/person/AnimationPlayer.get_animation("3d move right")
#	else:
#		yaw_offset.x = 0
#	if Input.is_action_pressed("front"):
#		yaw_offset.z = 1
#		move_anim = $col/person/AnimationPlayer.get_animation("3d move forwards")
#	elif Input.is_action_pressed("back"):
#		yaw_offset.z = -1
#		move_anim = $col/person/AnimationPlayer.get_animation("3d move backwads")
#	else:
#		yaw_offset.z = 0