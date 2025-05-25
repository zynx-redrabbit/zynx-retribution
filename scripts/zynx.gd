extends CanvasGroup
class_name Zynx

enum Parts {BODY, HEAD}
enum ShellType {DEFAULT, WING, FIRE, BAT, ROCKET}
enum Anims {RUN, JUMP, SHELL}

@export var character : Array[AnimatedSprite2D]
@export var colliders : Array[Area2D]
@export var player : PlayerControl

@export var shell_type : ShellType:
	set(value):
		if shell_type != value:
			shell_type = value
			self.shell_enum_changed(shell_type)
			
@export var selected_anim : Anims:
	set(value):
		if selected_anim != value:
			selected_anim = value
			self.anim_enum_changed(selected_anim)
			
var shell : String

var head_anim : String
var body_anim : String

var last_head_anim : String
var last_body_anim : String

var clicked : bool = false

var HEAD : AnimatedSprite2D
var BODY : AnimatedSprite2D

func _ready() -> void:
	self.HEAD = self.character[Parts.HEAD]
	self.BODY = self.character[Parts.BODY]
	self.shell = self.shell_name(ShellType.DEFAULT)
	self.update_animation(Anims.RUN)
		
func update_shell(type) -> void:
	var anim : String = self.body_anim.split('_')[1].to_upper()
	self.shell = self.shell_name(type)
	print(self.shell)
	self.update_animation(self.Anims.get(anim))
	
func update_animation(animation) -> void:
	self.last_head_anim = self.head_anim
	self.last_body_anim = self.body_anim
	self.head_anim = self.anim_name_head(animation)
	self.body_anim = self.anim_name_body(animation)
	self.HEAD.animation = self.head_anim
	self.BODY.animation = self.body_anim
	self.HEAD.play()
	self.BODY.play()
	
func anim_is(part : AnimatedSprite2D, animation : int):
	var current_anim : String = part.animation
	var anim : String = Anims.keys()[animation].to_lower()
		
	return current_anim.contains(anim)
	
func shell_name(type):
	self.shell = ShellType.keys()[type]
	self.shell = self.shell.to_lower()
	
	return self.shell
	
func anim_name_head(animation):
	self.head_anim = ShellType.keys()[ShellType.DEFAULT] + '_' + Anims.keys()[animation]
	self.head_anim = self.head_anim.to_lower()
	
	return self.head_anim
	
func anim_name_body(animation):
	self.body_anim = self.shell + '_' + Anims.keys()[animation]
	self.body_anim = self.body_anim.to_lower()
	
	return self.body_anim
	
func shell_enum_changed(type) -> void:
	self.shell = self.shell_name(type)
	self.update_shell(type)
	
func anim_enum_changed(animation) -> void:
	self.last_head_anim = self.head_anim
	self.last_body_anim = self.body_anim
	self.head_anim = self.anim_name_head(animation)
	self.body_anim = self.anim_name_body(animation)

func _on_col_body_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not self.clicked and event is InputEventMouseButton:
		var anim : String = self.BODY.animation
		if self.anim_is(self.BODY, Anims.RUN) or self.anim_is(self.BODY, Anims.JUMP):
			self.clicked = true
			self.update_animation(Anims.SHELL)
			player.slide()
			#self.update_shell(ShellType.WING)

func _on_body_animation_finished() -> void:
	if self.anim_is(self.BODY, Anims.SHELL):
		self.clicked = false
		self.update_animation(Anims.RUN)
		player.slide_complete()
