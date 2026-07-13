extends TextureButton

var holdres : Resource = null

@onready var anzahl: Label = $anzahl



func _on_pressed() -> void:
	if Base.wellelauft == true:
		return
	
	if holdres == null:
		return
	
	Base.emit_signal("bauplanturm", holdres)
	
	
	pass
