extends TextureButton

var holdres : Resource = null

@onready var qcharge: Label = $qcharge


func _ready() -> void:
	
	Base.updateinventar.connect(updateability)
	Base.qbutton.connect(_on_pressed)
	
	if holdres == null:
		return
	
	self.texture_normal = holdres.kartenbild
	qcharge.text = Base.ability[holdres.kartenname].aufladung
	
	
	pass



func updateability() -> void:
	
	if holdres == null:
		return
	
	self.texture_normal = holdres.kartenbild
	qcharge.text = str(Base.ability[holdres.kartenname].aufladung)
	
	
	
	pass


func _on_pressed() -> void:
	
	if holdres == null:
		return
	var spell = Base.ability[holdres.kartenname].pfad
	
	var realspell = spell.instantiate()
	
	get_tree().current_scene.kiste.add_child(realspell)
	
	realspell.global_position = get_global_mouse_position()
	
	Base.ability[holdres.kartenname].aufladung -= 1
	Base.emit_signal("updateinventar")
	
	
	pass
