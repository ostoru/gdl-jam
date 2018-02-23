extends RigidBody
export var active = false
func _ready():
	if active:
		set_process_input(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$"yaw/pitch/cam base/camera".make_current()
	pass

var mouse_relative_pos = Vector2()
func _input(event):
	if event is InputEventMouseMotion:
		mouse_relative_pos += event.relative

var offset_distance = 0
var sensitivity = .3
var max_cam_rot = 1.5
var min_cam_rot = -1.5
var speed = 0
func _physics_process(delta):
	if active:
		$yaw.rotate_y( -mouse_relative_pos.x * sensitivity * delta)
		$yaw/pitch.rotate_x(max(-.9,min(.9,-mouse_relative_pos.y * sensitivity * delta)))
		if $yaw/pitch.rotation.x > max_cam_rot:
			$yaw/pitch.rotation.x = max_cam_rot
		elif $yaw/pitch.rotation.x < min_cam_rot:
			$yaw/pitch.rotation.x = min_cam_rot
		mouse_relative_pos = Vector2()
		
		var yaw_offset = Vector3()
		var move_anim = $CollisionShape/person/AnimationPlayer.get_animation("3d move neutral")
		if Input.is_action_pressed("move_left"):
			yaw_offset.x = 1
			offset_distance += .001
			move_anim = $CollisionShape/person/AnimationPlayer.get_animation("3d move left")
		elif Input.is_action_pressed("move_right"):
			yaw_offset.x = -1
			offset_distance += .001
			move_anim = $CollisionShape/person/AnimationPlayer.get_animation("3d move right")
		else:
			offset_distance -= .0004
		if Input.is_action_pressed("move_forward"):
			yaw_offset.z = 1
			offset_distance += .001
			move_anim = $CollisionShape/person/AnimationPlayer.get_animation("3d move forwards")
		elif Input.is_action_pressed("move_backwards"):
			yaw_offset.z = -1
			offset_distance += .001
			move_anim = $CollisionShape/person/AnimationPlayer.get_animation("3d move backwads")
		else:
			offset_distance -= .0004
			
		print(move_anim)
		offset_distance = max(.5,min(.1,offset_distance))
		yaw_offset = yaw_offset.normalized()
		$yaw/pitch.set_translation((-yaw_offset) * offset_distance)
		if Input.is_action_pressed("run"):
			speed += 0.1
		else:
			speed -= 0.1
		speed = min(2,max(.7,speed))
		if speed >= 1:
			var character_look_difference = $CollisionShape/person.global_transform.origin - yaw_offset
			$CollisionShape/person.look_at(character_look_difference,Vector3(0,1,0))
		else:
			$CollisionShape/person.rotation = $yaw.rotation
		
		var test = ($yaw/pitch.get_global_transform().origin - $".".get_global_transform().origin).normalized() * delta * offset_distance * 1000
		test.y = 0
		linear_velocity = test
