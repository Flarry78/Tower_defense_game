extends Node2D


var gegnerspeed : int = 40
var punktevalue : int = 150
var life : float = 300
var slowcounter : int = 0

@onready var progress_bar: ProgressBar = $lifebar/ProgressBar
@onready var lifebar: Control = $lifebar



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
