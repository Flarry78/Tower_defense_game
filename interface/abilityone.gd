extends TextureButton

var holdres : Resource = null

@onready var qcharge: Label = $qcharge

var charges : int = 0


func _ready() -> void:
	
	Base.updateinventar.connect(updateability)
	Base.qbutton.connect(_on_pressed)
	
	
	pass



func updateability() -> void:
	
	if holdres == null:
		return
	
	qcharge.text = str(Base.ability[holdres.kartenname].aufladung)
	charges = Base.ability[holdres.kartenname].aufladung
	
	
	pass



func _on_pressed() -> void:
	
	if holdres == null:
		return
	var spell = Base.ability[holdres.kartenname].pfad
	
	if charges <= 0:
		return
	
	var realspell = spell.instantiate()
	
	get_tree().current_scene.kiste.add_child(realspell)
	
	realspell.global_position = get_global_mouse_position()
	
	charges -= 1
	qcharge.text = str(charges)
	
	
	pass
