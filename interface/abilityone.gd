extends TextureButton

var holdres : Resource = null

@onready var qcharge: Label = $qcharge


func _ready() -> void:
	
	Base.updateinventar.connect(updateability)
	
	
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
