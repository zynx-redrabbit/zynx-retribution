extends CanvasGroup

@export var scroll_speeds : Array[float]
@export var base_z_index : int
var sprites : Array[Sprite2D]

func _ready() -> void:
	var i = 0
	sprites = get_all_children()
	
	for sprite in sprites:
		var width = sprite.texture.get_width() * sprite.scale.x
		sprite.material.set_shader_parameter('speed', scroll_speeds[i])
		sprite.z_index = base_z_index + i
		var right_sprite:Sprite2D = sprite.duplicate()
		var left_sprite:Sprite2D = sprite.duplicate()
		right_sprite.position.x = width + sprite.position.x
		left_sprite.position.x = -width + sprite.position.x
		add_child(right_sprite)
		add_child(left_sprite)
		
		i=i+1


func get_all_children() -> Array[Sprite2D]:
	for N in self.get_children():
			self.sprites.append(N)

	return self.sprites
