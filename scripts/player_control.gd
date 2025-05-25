extends PhysicsControl
class_name  PlayerControl

@export var zynx_layers : Zynx
@export var jump_height : float = 300
@export var jump_distance : float = 350
@export var jump_speed : float = 1000
@export var slide_distance : float = 350
@export var slide_speed : float = 1600
@export var to_origin_speed : float = 80
@export var origin : Marker2D
@export var max : Marker2D

var ANIM : String = 'run'
var JUMP_COUNT : float = 0

var max_x : float
var min_x : float

var jump_max_x : float
var jump_min_x : float
var jump_max_y : float
var jump_min_y : float

var slide_max_x : float
var slide_min_x : float

func _ready() -> void:
	max_x = max.position.x
	min_x = origin.position.x
	
func update_jump_min_max() -> void:
	jump_max_x = position.x + jump_distance
	jump_min_x = position.x
	jump_max_y = position.y - jump_height
	jump_min_y = position.y
	
func jump() -> void:
	update_jump_min_max()
	ANIM = 'jump'
	
func jump_complete() -> void:
	ANIM = 'run'
	
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
	elif ANIM == 'jump':
		var x_damp = (position.x - jump_max_x) / (jump_min_x - jump_max_x)
		var y_damp = (position.y - jump_max_y) / (jump_min_y - jump_max_y)
		position.x = move_toward(position.x, jump_max_x, ((delta*jump_speed)*(x_damp*velocity_x_damp)))
		position.y = move_toward(position.y, jump_max_y, ((delta*jump_speed)*y_damp))
