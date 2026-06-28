extends TextureButton

var xbild : Texture = preload("res://assets/kreuz.png")

func _ready() -> void:
	
	Base.updateinventar.connect(aktuell)
	
	pass

var holdres : Resource = null

@onready var anzahl: Label = $anzahl

func aktuell() -> void:
	
	if holdres == null:
		anzahl.text = " "
		self.texture_normal = xbild
		return
	
	self.texture_normal = holdres.kartenbild
	anzahl.text = str(Base.basictower[holdres.kartenname].gebaut)
	
	if Base.basictower[holdres.kartenname].gebaut <= 0:
		holdres = null
		anzahl.text = " "
		self.texture_normal = xbild
	
	pass


func _on_pressed() -> void:
	if Base.wellelauft == true:
		return
	
	if holdres == null:
		return
	
	Base.emit_signal("bauplanturm", holdres)
	
	
	pass
