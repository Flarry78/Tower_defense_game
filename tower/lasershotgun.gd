extends Node2D

@onready var spotting: Area2D = $spotting
@onready var collision_shape_2d: CollisionShape2D = $spotting/CollisionShape2D
@onready var reload: Timer = $reload

@onready var bullet = preload("res://geschosse/laserschuss.tscn")

var turmgrose : Array[Vector2i] = [Vector2i(0,0),Vector2i(1,0),Vector2i(1,1),Vector2i(0,1)]

var schaden : float
var feuerrate : float

var allegegner : Array[Node2D] = []
var amschiesen : bool = false
var alleareas :  Array = []
var schussmenge : int = 4
var maxrange : float

func _ready() -> void:
	
	basestats()
	
	
	pass


func basestats() -> void:
	
	schaden = Base.basictower.Lasershotgun.schaden
	feuerrate = Base.basictower.Lasershotgun.feuerrate
	maxrange = Base.basictower.Lasershotgun.maxrange
	reload.wait_time = feuerrate
	
	pass


func _on_spotting_area_entered(area: Area2D) -> void:
	
	
	var dad = area.get_parent()
	
	if is_instance_valid(dad):
		allegegner.push_back(dad)
		if amschiesen == false and reload.is_stopped() == true:
			call_deferred("shoot")
			amschiesen = true
			reload.start()
	
	
	pass


func _on_spotting_area_exited(area: Area2D) -> void:
	var dad = area.get_parent()
	
	if is_instance_valid(dad):
		entfernen(dad)
	
	if allegegner.is_empty():
		reload.stop()
		amschiesen = false
	
	pass

func entfernen(dad) -> void:
	var weg : Array[Node2D] = []
	
	weg.append(dad)
	for i in weg:
		if is_instance_valid(i):
			allegegner.erase(i)
	
	pass



func shoot() -> void:
	
	for i in range(schussmenge):
		var realbullet = bullet.instantiate()
		var himmel : Vector2
		
		if i == 0:
			himmel = Vector2(0,1)
		elif i == 2:
			himmel = Vector2(-1,0)
		elif i == 3:
			himmel = Vector2(1,0)
		else: 
			himmel = Vector2(0,-1)
		
		
		var richtung = himmel
		realbullet.direction = richtung
		realbullet.dmgvalue = schaden
		realbullet.start = self.global_position
		realbullet.weite = maxrange
		get_tree().current_scene.get_node("kiste").add_child(realbullet)
		
		realbullet.global_position = self.global_position
	
	
	pass


func _on_reload_timeout() -> void:
	
	shoot()
	
	
	pass
