extends Node2D


@onready var turmbauplatz: Node2D = $turmbauplatz
@onready var ghost: Node2D = $ghost
@onready var spawn: Timer = $spawn
@onready var kiste: Node2D = $kiste
@onready var level: Node2D = $level

var levelpfade : Array[Path2D] = []
var bauzone : TileMapLayer
var baunummer : int = 2

@onready var enemys: Node2D = $enemys

var turma : PackedScene
var turmname : String


@onready var ram: Label = $ram
@onready var fps: Label = $fps
@onready var cpu: Label = $cpu
@onready var nodes: Label = $nodes
@onready var counter: Label = $counter



var zahl : int = 0
var willbauen : bool = false
var darfbauen : bool = true

var realtower : Node2D
var bauegerade : bool = false

func _ready() -> void:
	randomize()
	lademap()
	Base.startewelle.connect(rundenstart)
	datenanzeige()
	Base.bauplanturm.connect(bauenbutton)
	
	pass



func datenanzeige() -> void:
	
	var fpspro = Engine.get_frames_per_second()
	var memory = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024 / 1024
	var cpupro = Performance.get_monitor(Performance.TIME_PROCESS) * 100
	
	fps.text = "FPS " + str(fpspro)
	cpu.text = "CPU " + str(cpupro)
	ram.text = "RAM " +  str(memory)
	nodes.text = "ALLNODES " + str(get_tree().get_node_count())
	counter.text = "COUNTER " +  str(zahl)
	pass

func _process(delta: float) -> void:
	datenanzeige()
	ghosting()
	pfadelaufen(delta)
	
	pass

func lademap() -> void:
	var getmap : String = ""
	
	if Base.takecurrent == false:
		getmap = Base.addemaps()
	else:
		getmap = Base.currentmap
	
	Base.takecurrent = false
	
	var realmap = Base.allemaps[getmap].instantiate()
	level.add_child(realmap)
	var kinder = realmap.wege.get_children()
	for i in kinder:
		levelpfade.append(i)
	
	bauzone = realmap.baugebiet
	
	pass


func rundenstart() -> void:
	
	if Base.wellelauft == true:
		return
	
	
	Base.wellelauft = true
	willbauen = false
	bauegerade = false
	if realtower:
		realtower.queue_free()
	spawn.start()
	Base.runde += 1
	Base.emit_signal("updatehud")
	
	
	pass


func ghosting() -> void:
	
	if willbauen == false:
		return
	var mouse = get_global_mouse_position()
	var baunberech = bauzone.local_to_map(mouse)
	var snappedpos = bauzone.map_to_local(baunberech)
	
	
	realtower.global_position = snappedpos + Vector2(8,8)
	
	for i in realtower.turmgrose:
		var gros = i + baunberech
		var darfich = bauzone.get_cell_source_id(gros)
		if darfich == baunummer or Base.besetztefelder.has(gros):
			realtower.modulate = Color(1.0, 0.0, 0.0, 0.392)
			darfbauen = false
			break
		else:
			realtower.modulate = Color(0.298, 1.0, 0.0, 0.392)
			darfbauen = true
	
	
	pass

func bauenbutton(dataturm) -> void:
	
	turmname = dataturm.kartenname
	
	tooktower(turmname)
	
	pass



func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("bauen"):
		if Base.wellelauft == true or Base.kartenauswahl == true:
			return
		if bauegerade == true and darfbauen == true:
			finalplacing()
		else:
			Base.emit_signal("justbuild")
			
	
	
	if event.is_action_pressed("qability"):
		if Base.wellelauft == false:
			return
		Base.emit_signal("qbutton")
	
	
	if event.is_action_pressed("eability"):
		if Base.wellelauft == false:
			return
		Base.emit_signal("ebutton")
	
	
	pass



func tooktower(dername) -> void:
	
	var ladechoosen = Base.basictower[dername].pfad
	turma = ladechoosen
	
	bauturm()
	
	
	pass


var aktivepfade : Array[PathFollow2D] = []
var gegneranzahl : int = 0
var maxgegner : int = 30

func addmob() -> void:
	var gegner = getgegner()
	var pfad = getpfad()
	
	pfad.add_child(gegner)
	aktivepfade.append(pfad)
	
	pass

var getmob : String = "leer"

func getgegner() -> Node2D:
	
	if getmob == "leer":
		getmob = Base.rndmob.pick_random()
	
	var mob = Base.allegegner[getmob].instantiate()
	
	
	return mob


func getpfad() -> PathFollow2D:
	
	var rndpfad = levelpfade.pick_random()
	var neuerpfad = PathFollow2D.new()
	neuerpfad.rotates = false
	rndpfad.add_child(neuerpfad)
	
	return neuerpfad


func pfadelaufen(delta) -> void:
	
	var schmutzarray : Array[PathFollow2D] = []
	for i in aktivepfade:
		if is_instance_valid(i) and i.get_child_count() >= 1:
				var kind = i.get_child(0)
				i.progress = i.progress + kind.gegnerspeed * delta
		if i.progress_ratio >= 0.999:
			schmutzarray.append(i)
		if i.get_child_count() == 0:
			if not schmutzarray.has(i):
				schmutzarray.append(i)
	
	for b in schmutzarray:
		if is_instance_valid(b):
			if b.get_child_count() >= 0.999:
				if is_instance_valid(b.get_child(0)):
					var kind = b.get_child(0)
					if is_instance_valid(kind):
						b.remove_child(kind)
						kind.queue_free()
						Base.leben -= 1
						Base.emit_signal("updatehud")
			aktivepfade.erase(b)
			b.queue_free()
	
	if Base.wellelauft == true and Base.gegnergekommen == true:
		if aktivepfade.is_empty():
			Base.wellelauft = false
			Base.gegnergekommen = false
			Base.emit_signal("zeigekarten")
	
	pass

func finalplacing() -> void:
	if realtower == null:
		return
		
	var mouse = get_global_mouse_position()
	var baunberech = bauzone.local_to_map(mouse)
	var snappedpos = bauzone.map_to_local(baunberech)
	
	realtower.global_position = snappedpos + Vector2(8,8)
	
	for i in realtower.turmgrose:
		var gros = i + baunberech
		Base.besetztefelder[gros] = true
	
	
	willbauen = false
	bauegerade = false
	
	var finalturm = turma.instantiate()
	turmbauplatz.add_child(finalturm)
	finalturm.global_position = realtower.global_position
	Base.alleaktiventower.append(finalturm)
	zahl += 1
	Base.basictower[turmname].towerbesitz -= 1
	Base.emit_signal("updateinventar")
	
	realtower.queue_free()
	
	pass


func bauturm() -> void:
	
	if realtower != null:
		return
	
	realtower = turma.instantiate()
	
	ghost.add_child(realtower)
	
	
	willbauen = true
	bauegerade = true
	
	pass


func _on_spawn_timeout() -> void:
	
	if gegneranzahl >= maxgegner:
		spawn.stop()
		gegneranzahl = 0
		Base.gegnergekommen = true
		return
	
	addmob()
	gegneranzahl += 1
	
	
	pass
