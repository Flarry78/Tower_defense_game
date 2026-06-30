extends TextureButton

var holdres : Resource = null

@onready var echarge: Label = $echarge


func _ready() -> void:
	
	Base.updateinventar.connect(updateability)
	
	if holdres == null:
		return
	
	self.texture_normal = holdres.kartenbild
	echarge.text = Base.ability[holdres.kartenname].aufladung
	
	
	
	pass



func updateability() -> void:
	
	if holdres == null:
		return
	
	self.texture_normal = holdres.kartenbild
	echarge.text = str(Base.ability[holdres.kartenname].aufladung)
	
	
	
	pass
