extends PhysicsControl
class_name  PlayerControl

@export var jump_height : float = 200
@export var slide_distance : float = 350
@export var slide_speed : float = 1600
@export var to_origin_speed : float = 80
@export var origin : Marker2D
@export var max : Marker2D

var ANIM : String = 'run'
var JUMP_COUNT : float = 0

var max_x : float
var min_x : float

var slide_max_x : float
var slide_min_x : float

func _ready() -> void:
	max_x = max.position.x
	min_x = origin.position.x
	
func update_slide_min_max() -> void:
	slide_max_x = position.x + slide_distance
	slide_min_x = position.x
	
func slide() -> void:
	update_slide_min_max()
	ANIM = 'shell'
	
func slide_complete() -> void:
	ANIM = 'run'

func _physics_process(delta: float) -> void:
	base_physics(delta)
	var velocity_x_damp = (position.x - max_x) / (min_x - max_x)
	#print(position.distance_to(origin.position))
	#print(velocity_x_damp)
	if ANIM == 'run':
		position.x = move_toward(position.x, origin.position.x, (delta*to_origin_speed))
	elif ANIM == 'shell':
		var slide_damp = (position.x - slide_max_x) / (slide_min_x - slide_max_x)
		position.x = move_toward(position.x, slide_max_x, ((delta*slide_speed)*(slide_damp*velocity_x_damp)))
	
func set_anim(anim):
	ANIM = anim
