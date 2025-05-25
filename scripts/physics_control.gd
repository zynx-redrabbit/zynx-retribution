extends CharacterBody2D
class_name PhysicsControl

@export var speed : float = 300
@export var jump_velocity : float = -400
@export var gravity_mult :float = 1

func gravity(delta) -> void:
	velocity.y += get_gravity().y * (delta*gravity_mult)

func base_physics(delta: float) -> void:
	gravity(delta)
	move_and_slide()

	
