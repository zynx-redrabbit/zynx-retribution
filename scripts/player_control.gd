extends PhysicsControl
class_name  PlayerControl

@export var zynx_layers : Zynx
@export var jump_height : float = 400
@export var jump_distance : float = 350
@export var jump_speed : float = 1000
@export var jump_y_duration : float = 0.25
@export var can_jump : bool = true
@export var slide_distance : float = 350
@export var slide_speed : float = 1600
@export var slide_cooldown_duration : float = 0.3
@export var can_slide : bool = true
@export var to_origin_speed : float = 150
@export var origin : Vector2
@export var max : Vector2

enum Anims {RUN, JUMP, SHELL}
var ANIM : int = 0
var JUMP_COUNT : float = 0

var max_x : float
var min_x : float

var jump_max_x : float
var jump_min_x : float
var jump_max_y : float
var jump_min_y : float

var jump_y_timer : Timer = Timer.new()
var slide_cooldown_timer : Timer = Timer.new()

var slide_max_x : float
var slide_min_x : float

func _ready() -> void:
	#var screensize = DisplayServer.screen_get_size()
	var screensize = get_parent().get_viewport_rect().size
	var half_screen_x = screensize.x /2
	var x_seg = half_screen_x / 8
	max_x = half_screen_x
	min_x = -x_seg * 6
	origin = Vector2(min_x, 207)
	max = Vector2(max_x, 207)
	add_child(jump_y_timer)
	add_child(slide_cooldown_timer)
	jump_y_timer.one_shot = true
	slide_cooldown_timer.one_shot = true
	
func update_jump_min_max() -> void:
	jump_max_x = position.x + jump_distance
	jump_min_x = position.x
	jump_max_y = position.y - jump_height
	jump_min_y = position.y
	jump_y_timer.start(jump_y_duration)
	can_jump = false
	
func jump() -> void:
	update_jump_min_max()
	ANIM = Anims.JUMP
	
func jump_complete() -> void:
	ANIM = Anims.RUN
	can_jump = true
	
func update_slide_min_max() -> void:
	slide_max_x = position.x + slide_distance
	slide_min_x = position.x
	can_jump = false
	can_slide = false
	slide_cooldown_timer.start(slide_cooldown_duration)
	
func slide() -> void:
	update_slide_min_max()
	ANIM = Anims.SHELL
	
func slide_complete() -> void:
	ANIM = Anims.SHELL
	can_jump = true
	can_slide = true

func _physics_process(delta: float) -> void:
	base_physics(delta)
	var velocity_x_damp = (position.x - max_x) / (min_x - max_x)
	#print(position.distance_to(origin.position))
	#print(velocity_x_damp)
	if ANIM == Anims.RUN:
		position.x = move_toward(position.x, origin.x, (delta*to_origin_speed))
		
	elif ANIM == Anims.SHELL:
		var slide_damp = (position.x - slide_max_x) / (slide_min_x - slide_max_x)
		position.x = move_toward(position.x, slide_max_x, ((delta*slide_speed)*(slide_damp*velocity_x_damp)))
		if slide_cooldown_timer.time_left == 0:
			slide_cooldown_timer.stop()
			can_slide = true
			
	elif ANIM == Anims.JUMP:
		var x_damp = (position.x - jump_max_x) / (jump_min_x - jump_max_x)
		var y_damp = (position.y - jump_max_y) / (jump_min_y - jump_max_y)
		#var y_damp = sin(3.14 * ((position.y - jump_max_y) / (jump_min_y - jump_max_y)))
		#print(y_damp)
		
		position.x = move_toward(position.x, jump_max_x, ((delta*jump_speed)*(x_damp*velocity_x_damp)))
		
		if jump_y_timer.time_left > 0:
			var y_speed = speed * 4;
			position.y = move_toward(position.y, jump_max_y, ((delta*y_speed)*y_damp))
			#print(position.y)
		else:
			can_jump = true
			jump_y_timer.stop()
