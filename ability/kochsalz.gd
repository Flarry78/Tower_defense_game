extends Node2D

var myname : String = "Kochsalz"
var schaden : float = 5
var feuerrate : float = 0.3

var gegnerimbereich : Array[Area2D] = []

func _ready() -> void:
	
	basestats()
	Base.dottick.connect(dodmg)
	
	pass

var time : float = 0.0
var duration : float

func basestats() -> void:
	
	duration = Base.ability.Kochsalz.dauer
	
	
	pass

func _process(delta: float) -> void:
	
	time += delta
	
	if time >= duration:
		queue_free()
	
	
	pass


func dodmg() -> void:
	
	for i in gegnerimbereich:
		if is_instance_valid(i):
			var papa = i.get_parent()
			if papa.has_method("damage"):
				papa.damage(schaden)
	
	
	pass



func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if is_instance_valid(area):
		gegnerimbereich.append(area)
		var papa = area.get_parent()
		papa.slowcounter += 1
		if papa.slowcounter <= 1:
			papa.gegnerspeed -= 15
			
	
	pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	
	if is_instance_valid(area):
		gegnerimbereich.erase(area)
		var papa = area.get_parent()
		papa.slowcounter -= 1
		if papa.slowcounter <= 0:
			papa.gegnerspeed += 15
			
	
	
	pass
