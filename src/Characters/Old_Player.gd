extends BobbingCharacter

func _physics_process(delta: float) -> void:
	#var is_jump_interrupted: = Input.is_action_just_released("player_jump") and velocity.y < 0.0
	var direction: = get_direction()
	#velocity = calculate_move_velocity(velocity, direction, speed_cap, is_jump_interrupted)
	velocity = calculate_move_velocity(velocity, direction, speed_cap, false)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2 (
		Input.get_action_strength("player_right") - Input.get_action_strength("player_left"),
		#-1.0 if Input.is_action_just_pressed("player_jump") and is_on_floor() else 1.0
		1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
