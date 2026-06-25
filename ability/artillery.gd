extends Node2D

@onready var reload: Timer = $reload


var patrone = preload("res://geschosse/patronenschuss.tscn")
var bereichradius : float = 64
var feuerrate : float = 0.3
var schaden : float = 50
var time : float
var duration : float = 10

func _ready() -> void:
	
	basestats()
	reload.start()
	
	pass

func basestats() -> void:
	
	reload.wait_time = feuerrate
	
	pass



func _process(delta: float) -> void:
	
	time += delta
	
	if time >= duration:
		queue_free()
	
	pass


func bereich() -> Vector2:
	
	var angle = randf() * TAU
	var distance = randf() * bereichradius
	var pos = self.global_position + Vector2(cos(angle), sin(angle)) * distance
	
	return pos


func _on_reload_timeout() -> void:
	
	shoot()
	
	pass


func shoot() -> void:
	
	var realpatrone = patrone.instantiate()
	self.add_child(realpatrone)
	realpatrone.global_position = bereich()
	realpatrone.dmgvalue = schaden
	
	pass
