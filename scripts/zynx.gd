extends CanvasGroup

enum Parts {BODY, HEAD}
enum ShellType {DEFAULT, WING, FIRE, BAT, ROCKET}
enum Anims {RUN, JUMP, SHELL}

@export var character : Array[AnimatedSprite2D]
@export var colliders : Array[Area2D]

@export var shell_type: ShellType:
	set(value):
		if shell_type != value:
			shell_type = value
			self.on_shell_type_changed(shell_type)
			
@export var selected_anim: Anims:
	set(value):
		if selected_anim != value:
			selected_anim = value
			self.on_anim_changed(selected_anim)
			
			
var shell : String
var head_anim : String
var body_anim : String


func _ready() -> void:
	self.shell = self.shell_name(ShellType.DEFAULT)
	self.head_anim = self.anim_name_head(Anims.RUN)
	self.body_anim = self.anim_name_body(Anims.RUN)
	for sprite in self.character:
		sprite.play()
		
func update_shell(type) -> void:
	print('update shell')
	var anim : String = self.body_anim.split('_')[1].to_upper()
	self.shell = self.shell_name(type)
	print(self.shell)
	self.update_animation(self.Anims.get(anim))
	
func update_animation(animation) -> void:
	print('switch animation')
	self.head_anim = self.anim_name_head(animation)
	self.body_anim = self.anim_name_body(animation)
	var head : AnimatedSprite2D = self.character[Parts.HEAD]
	var body : AnimatedSprite2D = self.character[Parts.BODY]
	head.animation = self.head_anim
	body.animation = self.body_anim
	head.play()
	body.play()
	
	
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
	
func on_shell_type_changed(type) -> void:
	self.shell = self.shell_name(type)
	self.update_shell(type)
	
func on_anim_changed(animation) -> void:
	self.head_anim = self.anim_name_head(animation)

func _on_col_body_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("!")
		self.update_animation(Anims.SHELL)
		self.update_shell(ShellType.WING)
		
	
	
		

	
