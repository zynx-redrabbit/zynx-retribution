extends Node2D

@export var game_canvas : CanvasGroup
@export var _player : PackedScene
@export var _levels : Array[PackedScene]
enum selected_level {TEST}

var level : Level
var zynx : Zynx

func _ready() -> void:
	var level = _levels[selected_level.TEST].instantiate()
	var player = _player.instantiate()
	game_canvas.add_child(level)
	level.add_child(player)
	player.position = level.player_spawn.position
	zynx = player.zynx_layers
	
func _on_screen_tap_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not zynx.clicked and event is InputEventMouseButton:
		print('screen tap')
		zynx.jump()
