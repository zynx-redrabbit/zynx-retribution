extends CanvasGroup
class_name CharacterLayers

enum Parts {BODY, FX}
enum Anims {WALK, SHELL}
enum Direction {RIGHT, LEFT}

@export var character : Array[AnimatedSprite2D]
@export var colliders : Array[Area2D]

var last_anim : String
var anim : String

var last_dir : String
var dir : String

var BODY : AnimatedSprite2D

@export var selected_anim : Anims:
	set(value):
		if selected_anim != value:
			selected_anim = value
			self.anim_enum_changed(selected_anim)
		self.update_animation(selected_anim)
			
@export var selected_dir : Direction:
	set(value):
		if selected_dir != value:
			selected_dir = value
			self.dir_enum_changed(selected_dir)
			
func _ready() -> void:
	self.BODY = self.character[Parts.BODY]
	#self.update_animation(Anims.WALK)
	
func update_animation(animation) -> void:
	self.last_anim = self.anim
	self.anim = self.anim_name(animation)
	self.BODY.animation = self.anim
	self.BODY.play()
	
func anim_name(animation):
	self.anim = Anims.keys()[animation]
	self.anim = self.anim.to_lower()
	
	return self.anim
	
func anim_enum_changed(selected) -> void:
	self.anim = Anims.keys()[selected]
	self.anim = self.anim.to_lower()
	
func dir_enum_changed(selected) -> void:
	self.dir = Direction.keys()[selected]
	self.dir = self.dir.to_lower()
