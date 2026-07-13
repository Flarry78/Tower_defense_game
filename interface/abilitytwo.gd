extends TextureButton

var holdres : Resource = null

@onready var echarge: Label = $echarge

var charges : int = 0

func _ready() -> void:
	
	Base.updateinventar.connect(updateability)
	Base.ebutton.connect(_on_pressed)
	
	
	pass



func updateability() -> void:
	
	if holdres == null:
		return
	
	echarge.text = str(Base.ability[holdres.kartenname].aufladung)
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
	echarge.text = str(charges)
	
	
	
	pass
