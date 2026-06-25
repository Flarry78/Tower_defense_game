extends CanvasLayer



func _on_start_pressed() -> void:
	
	var lademain = load("res://base/main.tscn")
	
	get_tree().change_scene_to_packed(lademain)
	
	pass


func _on_exit_pressed() -> void:
	
	get_tree().quit()
	
	pass
