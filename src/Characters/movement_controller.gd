extends KinematicBody2D

export var max_speed = 1

func _physics_process(delta: float) -> void:
	var direction = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	var velocity = max_speed * direction # Don't multiply by delta, as move_and_slide() does it already
	clamp(velocity, -max_speed, max_speed)
	velocity = move_and_slide(Vector2(velocity, 0)).x
	translate(Vector2(self.transform.origin.x, get_parent().transform.origin.y))
