extends Node2D

@export var levels : Array[PackedScene]
enum selected_level {TEST}

func _ready() -> void:
	var level = levels[selected_level.TEST].instantiate()
	add_child(level)
	
