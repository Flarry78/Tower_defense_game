extends Node2D


@onready var spotting: Area2D = $spotting

var turmgrose : Array[Vector2i] = [Vector2i(0,0),Vector2i(1,0),Vector2i(1,1),Vector2i(0,1)]

var allegegner : Array[Node2D] = []
var alleareas :  Array = []


func _ready() -> void:
	basestats()
	
	
	pass

func basestats() -> void:
	
	pass
