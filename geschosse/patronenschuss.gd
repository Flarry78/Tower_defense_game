extends Area2D

var dmgvalue : float

func _ready() -> void:
	
	destroy()
	
	pass


func _on_area_entered(area: Area2D) -> void:
	
	if is_instance_valid(area):
		var parent = area.get_parent()
		if parent.has_method("damage"):
			parent.damage(dmgvalue)
	
	
	pass


func destroy() -> void:
	
	
	await get_tree().create_timer(5.2).timeout
	self.monitoring = false
	call_deferred("queue_free")
	
	
	pass
