extends RigidBody2D

export var raycast_length = 8.0
export var print_ray_hit_messages = false
export var jump_strength = -100
export var jumps_remaining = 0
export var default_jumps = 1

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var timer = get_node("jump_timer")
	
	var location = get_global_transform().origin
	var space_state = get_world_2d().direct_space_state
	# Be sure to use GLOBAL coordinates, not LOCAL to node.
	var raycast_result = space_state.intersect_ray(
		Vector2(location.x, location.y - 1), 
		Vector2(location.x, location.y + raycast_length), 
		[self], 
		8)
	if len(raycast_result) != 0:
		jumps_remaining = default_jumps
		self.transform = Transform2D(0.0, Vector2(
			self.transform.origin.x, 
			raycast_result.position.y - raycast_length))
		if print_ray_hit_messages: print("Ray hit!")
	else:
		if print_ray_hit_messages: print("No ray collision.")
	
	if Input.is_action_just_pressed("player_jump"):
		if jumps_remaining > 0 and timer.get_time_left() == 0:
			timer.start()
			apply_impulse(Vector2.ZERO, Vector2(0, jump_strength))
			jumps_remaining -= 1
			print("Jumps remaining: " + String(jumps_remaining))

#export var jump_acceleration_speed = 150
#export var gravity = 100.0
#export var max_vertical_velocity = [20000.0, -1000.0]
#
#export var raycast_length = 8.0
#export var print_ray_hit_messages = false
#
#func _physics_process(delta: float) -> void:
#	var vertical_velocity = 0.0
#	var horizontal_velocity = 0.0
#	var timer = get_node("jump_timer")
#
#	var location = get_global_transform().origin
#	var space_state = get_world_2d().direct_space_state
#	# Be sure to use GLOBAL coordinates, not LOCAL to node.
#	var raycast_result = space_state.intersect_ray(Vector2(location.x, location.y - 1), Vector2(location.x, location.y + raycast_length), [self], 8)
#	if len(raycast_result) != 0:
#		self.transform = Transform2D(0.0, Vector2(self.transform.origin.x, raycast_result.position.y - raycast_length))
#		if print_ray_hit_messages: print("Ray hit!")
#	else:
#		if print_ray_hit_messages: print("No ray collision.")
#
#	if Input.is_action_pressed("player_jump"):
#		if len(raycast_result) != 0: timer.start(); print("Starting timer.")
#		if timer.get_time_left() != 0:
#			print("Adding vertical velocity.")
#			vertical_velocity -= jump_acceleration_speed
#			#vertical_velocity = clamp(vertical_velocity, max_vertical_velocity[0], max_vertical_velocity[1])
#	if Input.is_action_just_released("player_jump"):
#		print("Stopping timer.")
#		timer.stop()
#
#	if timer.get_time_left() == 0 and len(raycast_result) == 0:
#		print("Removing vertical velocity.")
#		vertical_velocity += gravity
#		vertical_velocity = clamp(vertical_velocity, max_vertical_velocity[1], max_vertical_velocity[0])
#
#	move_and_slide(Vector2(horizontal_velocity, vertical_velocity), Vector2.UP)
