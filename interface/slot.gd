extends TextureButton

var holdres : Resource = null
var slotgrose : int = 0

@onready var anzahl: Label = $anzahl

func aktuell() -> void:
	
	anzahl.text = str(slotgrose)
	
	pass


func _on_pressed() -> void:
	
	if holdres == null:
		return
	
	Base.emit_signal("bauplanturm", holdres)
	
	
	pass
