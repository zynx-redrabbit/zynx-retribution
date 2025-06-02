extends CharacterBody2D
class_name CharacterObstacle

@export var character : CharacterLayers

func _ready() -> void:
	character.selected_anim = character.Anims.SHELL
