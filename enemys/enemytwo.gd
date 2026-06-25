extends Node2D


var gegnerspeed : int = 30
var punktevalue : int = 100
var life : float = 600
var slowcounter : int = 0

@onready var lifebar: Control = $lifebar
@onready var progress_bar: ProgressBar = $lifebar/ProgressBar


func _ready() -> void:
	
	stats()
	
	pass

func stats() -> void:
	
	progress_bar.max_value = life
	progress_bar.value = life
	updatehealth()
	
	pass

func updatehealth() -> void:
	
	progress_bar.value = life
	
	pass

func damage(dmg) -> void: 
	
	life -= dmg
	if life <= 0:
		Base.punktzahl += punktevalue
		queue_free()
	
	updatehealth()
	pass
