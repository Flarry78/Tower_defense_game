extends Node2D

@onready var durchmesser: CollisionShape2D = $spreadarea/durchmesser
@onready var abilitybild: Texture2D = load("res://assets/desinade.png")

var schaden : float = 5
var feuerrate : float = 0.3
var flachenradius : float = 150
var ausbreitezeit : float = 5

@export var diekurve : Curve

var gegnerimbereich : Array[Area2D] = []

func _ready() -> void:
	
	Base.dottick.connect(dodmg)
	
	pass

var progress
var time : float = 0.0
var duration : float = 10
var curve_value
var start_size : Vector2 = Vector2(0.1,0.1)
var target_size : Vector2 = Vector2(2,2)

func _process(delta: float) -> void:
	
	time += delta
	
	if time >= duration:
		queue_free()
	
	progress = clamp(time / ausbreitezeit, 0.0, 1.0)
	
	
	if diekurve:
		curve_value = clamp(diekurve.sample(progress), 0.0, 1.0)
		var size = lerp(start_size, target_size, curve_value)
		
		self.scale = size
	
	
	pass

func dodmg() -> void:
	
	for i in gegnerimbereich:
		if is_instance_valid(i) and is_instance_valid(i.get_parent()):
			var papa = i.get_parent()
			if papa.has_method("damage"):
				papa.damage(schaden)
	
	pass

func _on_spreadarea_area_entered(area: Area2D) -> void:
	
	if is_instance_valid(area):
		gegnerimbereich.append(area)
	
	
	pass


func _on_spreadarea_area_exited(area: Area2D) -> void:
	
	if is_instance_valid(area):
		gegnerimbereich.erase(area)
	
	pass
