extends Area2D

var direction
var speed : int = 400
var dmgvalue : float
var start : Vector2
var weite : float


func _ready() -> void:
	
	self.look_at(direction)
	
	pass



func _process(delta: float) -> void:
	
	self.global_position += speed * direction * delta
	var reichweite = self.global_position.distance_to(start)
	if reichweite >= weite:
		queue_free()
	
	
	
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	
	queue_free()
	
	pass


func _on_area_entered(area: Area2D) -> void:
	
	if is_instance_valid(area):
		var parent = area.get_parent()
		if parent.has_method("damage"):
			parent.damage(dmgvalue)
	
	
	queue_free()
	
	
	pass
