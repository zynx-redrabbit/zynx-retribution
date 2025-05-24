extends CanvasGroup

enum Parts {BODY, HEAD}
enum ShellType {DEFAULT, WING, FIRE, BAT, ROCKET}

@export var character : Array[AnimatedSprite2D]
@export var colliders : Array[Area2D]
@export var shell_type: ShellType

func _on_col_body_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("!")
