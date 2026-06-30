extends CanvasLayer

@onready var lebenanzeige: Label = $hudbar/lebenanzeige
@onready var rundenanzeige: Label = $hudbar/rundenanzeige
@onready var escapemenu: Control = $gamefenster/escapemenu
@onready var losescreen: Control = $gamefenster/losescreen
@onready var finalpunkte: Label = $gamefenster/losescreen/finalpunkte

@onready var karten: Control = $gamefenster/karten
@onready var kartcontainer: HBoxContainer = $gamefenster/karten/kartcontainer
@onready var karteone: Control = $gamefenster/karten/kartcontainer/karteone
@onready var karteone_2: Control = $gamefenster/karten/kartcontainer/karteone2
@onready var karteone_3: Control = $gamefenster/karten/kartcontainer/karteone3
@onready var karteone_4: Control = $gamefenster/karten/kartcontainer/karteone4
@onready var kartenbutton: Button = $hudbar/kartenbutton


@onready var abilityone: TextureButton = $hudbar/abilityslots/HBoxContainer/abilityone
@onready var abilitytwo: TextureButton = $hudbar/abilityslots/HBoxContainer/abilitytwo




@onready var konebild: TextureRect = $gamefenster/karten/kartcontainer/karteone/konebild
@onready var konetext: RichTextLabel = $gamefenster/karten/kartcontainer/karteone/konetext
@onready var ktwobild: TextureRect = $gamefenster/karten/kartcontainer/karteone2/ktwobild
@onready var ktwotext: RichTextLabel = $gamefenster/karten/kartcontainer/karteone2/ktwotext
@onready var kthreebild: TextureRect = $gamefenster/karten/kartcontainer/karteone3/kthreebild
@onready var kthreetext: RichTextLabel = $gamefenster/karten/kartcontainer/karteone3/kthreetext
@onready var kfourbild: TextureRect = $gamefenster/karten/kartcontainer/karteone4/kfourbild
@onready var kfourtext: RichTextLabel = $gamefenster/karten/kartcontainer/karteone4/kfourtext

@onready var towergrid: GridContainer = $hudbar/towerbar/towergrid

var spezialwahlupgrade : bool = false
var spezialwahlturm : bool = false

var inventar : Array = []


func _ready() -> void:
	
	anzeigeupdaten()
	Base.updatehud.connect(anzeigeupdaten)
	Base.zeigekarten.connect(kartenchoose)
	escapemenu.visible = false
	losescreen.visible = false
	kartenbutton.visible = false
	karten.visible = false
	inventar = towergrid.get_children()
	
	pass



func kartenchoose() -> void:
	var allekarten : Array = [karteone,karteone_2,karteone_3,karteone_4]
	
	for i in allekarten:
		i.holdres = null
		i.modulate.a = 0.8
		i.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var getbutton = i.get_child(3)
		getbutton.disabled = true
	
	Base.kartenauswahl = true
	karten.visible = true
	kartenbutton.visible = true
	
	if spezialwahlturm == true:
		towerwahl()
		return
	
	if spezialwahlupgrade == true:
		upgradewahl()
		return
	
	
	if Base.runde in Base.abilitywahl:
		abilitywahl()
	
	
	if Base.runde in Base.towerwahl:
		towerwahl()
	
	
	if Base.runde in Base.upgradewahl:
		upgradewahl()
	
	
	if Base.runde in Base.specialwahl:
		specialwahl()
	
	if Base.runde in Base.endwahl:
		endwahl()
	
	
	for leer in allekarten:
		if leer.modulate.a <= 0.9:
			var leerbild = leer.get_child(1)
			var leertext = leer.get_child(2)
			var bilda = load("res://assets/kreuz.png")
			leerbild.texture = bilda
			leertext.text = ""
	
	
	pass

func towerwahl() -> void:
	var allekarten : Array = [karteone,karteone_2,karteone_3,karteone_4]
	
	var rndkarts = Base.towerpool.duplicate()
		
	for cardzahl in range(Base.towerkartenanzahl):
		if rndkarts.is_empty():
			break
		var rndkart = rndkarts.pick_random()
		var card =  allekarten[cardzahl]
		card.holdres = Base.basictower[rndkart].respfad
		var kind = card.get_child(1)
		card.modulate.a = 1
		card.mouse_filter = Control.MOUSE_FILTER_PASS
		var getdbutton = card.get_child(3)
		getdbutton.disabled = false
		
		if Base.basictower.has(rndkart): 
			var bildmachen : Resource = Base.basictower[rndkart].respfad
			kind.texture = bildmachen.kartenbild
			rndkarts.erase(rndkart)
			var texte = card.get_child(2)
			texte.text = bildmachen.kartentext
	
	spezialwahlturm = false
	pass

func abilitywahl() -> void:
	var allekarten : Array = [karteone,karteone_2,karteone_3,karteone_4]
	
	var rndkarts = Base.abilitypool.duplicate()
		
	for cardzahl in range(Base.abilitykartenanzahl):
		if rndkarts.is_empty():
			break
		var rndkart = rndkarts.pick_random()
		var card =  allekarten[cardzahl]
		card.holdres = Base.ability[rndkart].respfad
		var kind = card.get_child(1)
		card.modulate.a = 1
		card.mouse_filter = Control.MOUSE_FILTER_PASS
		var getdbutton = card.get_child(3)
		getdbutton.disabled = false
		
		if Base.ability.has(rndkart): 
			var bildmachen : Resource = Base.ability[rndkart].respfad
			kind.texture = bildmachen.kartenbild
			rndkarts.erase(rndkart)
			var texte = card.get_child(2)
			texte.text = bildmachen.kartentext
	
	spezialwahlupgrade = false
	pass

func upgradewahl() -> void:
	var allekarten : Array = [karteone,karteone_2,karteone_3,karteone_4]
	
	var rndkarts = Base.upgradepool.duplicate()
	
	for cardzahl in range(Base.upgradeskartenanzahl):
		if rndkarts.is_empty():
			break
		var rndkart = rndkarts.pick_random()
		var card =  allekarten[cardzahl]
		card.holdres = Base.allupgrades[rndkart].respfad
		var kind = card.get_child(1)
		card.modulate.a = 1
		card.mouse_filter = Control.MOUSE_FILTER_PASS
		var getdbutton = card.get_child(3)
		getdbutton.disabled = false
		
		if Base.allupgrades.has(rndkart): 
			var bildmachen : Resource = Base.allupgrades[rndkart].respfad
			kind.texture = bildmachen.kartenbild
			rndkarts.erase(rndkart)
			var texte = card.get_child(2)
			texte.text = bildmachen.kartentext
	
	
	pass

func specialwahl() -> void:
	
	var zufallturm : Resource = load("res://reso/spezialturm.tres")
	var zufallupgrade : Resource = load("res://reso/spezialupgrade.tres")
	
	var allekarten : Array = [karteone,karteone_2,karteone_3,karteone_4]
	
	var kartetower = allekarten[0]
	var karteupgrade = allekarten[1]
	kartetower.holdres = zufallturm
	karteupgrade.holdres = zufallupgrade
	
	kartetower.modulate.a = 1
	kartetower.mouse_filter = Control.MOUSE_FILTER_PASS
	var getdbutton = kartetower.get_child(3)
	getdbutton.disabled = false
	
	karteupgrade.modulate.a = 1
	karteupgrade.mouse_filter = Control.MOUSE_FILTER_PASS
	var getdbuttontwo = karteupgrade.get_child(3)
	getdbuttontwo.disabled = false
	
	var ktbild = kartetower.get_child(1)
	var kttext = kartetower.get_child(2)
	ktbild.texture = zufallturm.kartenbild
	kttext.text = zufallturm.kartentext
	
	var kabild = karteupgrade.get_child(1)
	var katext = karteupgrade.get_child(2)
	kabild.texture = zufallupgrade.kartenbild
	katext.text = zufallupgrade.kartentext
	
	
	pass
	
func endwahl() -> void:
	
	print("episch upgrades")
	
	
	pass
	
	
	
func _input(event: InputEvent) -> void:
	
	
	if event.is_action_pressed("escape"):
		toggle_pause()
	
	
	pass


func toggle_pause():
	
	if get_tree().paused:
		resume_game()
	else:
		pause_game()
		
	pass

func pause_game():
	
	get_tree().paused = true
	escapemenu.visible = true
	
	pass

func resume_game():
	
	get_tree().paused = false
	escapemenu.visible = false
	
	pass



func anzeigeupdaten() -> void:
	
	lebenanzeige.text = "Leben  : " + str(Base.leben)
	rundenanzeige.text = "Runde : " + str(Base.runde)
	if Base.leben <= 0:
		finalpunkte.text = str(Base.punktzahl)
		toggle_pause()
		losescreen.visible = true
	
	
	pass



func _on_startrundebutton_pressed() -> void:
	
	if Base.kartenauswahl == true:
		return
	
	Base.emit_signal("startewelle")
	
	pass


func _on_resume_pressed() -> void:
	
	toggle_pause()
	
	pass


func _on_newlevel_pressed() -> void:
	
	toggle_pause()
	Base.fullreset()
	get_tree().reload_current_scene()
	
	pass


func _on_exitbutton_pressed() -> void:
	
	get_tree().quit()
	
	pass


func _on_restartnew_pressed() -> void:
	
	toggle_pause()
	Base.fullreset()
	get_tree().reload_current_scene()
	
	pass


func _on_exit_pressed() -> void:
	
	get_tree().quit()
	
	pass


func _on_restartcurrent_pressed() -> void:
	
	Base.takecurrent = true
	toggle_pause()
	Base.fullreset()
	get_tree().reload_current_scene()
	
	pass


func _on_restartthismap_pressed() -> void:
	
	Base.takecurrent = true
	toggle_pause()
	Base.fullreset()
	get_tree().reload_current_scene()
	
	pass



func _on_buttonone_pressed() -> void:
	
	var meins = karteone
	
	if meins.holdres.kartentyp == "Turm":
		for slot in inventar:
			if slot.holdres == null:
				slot.holdres = meins.holdres
				Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
				break
			elif slot.holdres != null:
				if slot.holdres.kartenname == meins.holdres.kartenname:
					Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
					print("is gleich")
					break
	
	if meins.holdres.kartentyp == "Ability":
		if abilityone.holdres == null:
			abilityone.holdres = meins.holdres
			Base.ability[meins.holdres.kartenname].aufladung += meins.holdres.abilityanzahl
		elif abilitytwo.holdres == null:
			abilitytwo.holdres = meins.holdres
			Base.ability[meins.holdres.kartenname].aufladung += meins.holdres.abilityanzahl
	
	
	if meins.holdres.kartentyp == "Upgrade":
		print("is ein upgrade")
	
	if meins.holdres.kartentyp == "Spezial":
		if meins.holdres.kartenname == "zufallturm":
			spezialwahlturm = true
			kartenchoose()
			return
	
	Base.emit_signal("updateinventar")
	
	karten.visible = false
	Base.kartenauswahl = false
	kartenbutton.visible = false
	
	pass


func _on_buttontwo_pressed() -> void:
	
	var meins = karteone_2
	
	if meins.holdres.kartentyp == "Turm":
		for slot in inventar:
			if slot.holdres == null:
				slot.holdres = meins.holdres
				Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
				break
			elif slot.holdres != null:
				if slot.holdres.kartenname == meins.holdres.kartenname:
					Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
					print("is gleich")
					break
	
	if meins.holdres.kartentyp == "Ability":
		if abilityone.holdres == null:
			abilityone.holdres = meins.holdres
			Base.ability[meins.holdres.kartenname].aufladung += meins.holdres.abilityanzahl
		elif abilitytwo.holdres == null:
			abilitytwo.holdres = meins.holdres
			Base.ability[meins.holdres.kartenname].aufladung += meins.holdres.abilityanzahl
	
	
	if meins.holdres.kartentyp == "Upgrade":
		print("is ein upgrade")
	
	if meins.holdres.kartentyp == "Spezial":
		if meins.holdres.kartenname == "zufallupgrade":
			spezialwahlupgrade = true
			kartenchoose()
			return
	
	
	Base.emit_signal("updateinventar")
	
	karten.visible = false
	Base.kartenauswahl = false
	kartenbutton.visible = false
	
	
	
	pass


func _on_buttonthree_pressed() -> void:
	
	var meins = karteone_3
	
	if meins.holdres.kartentyp == "Turm":
		for slot in inventar:
			if slot.holdres == null:
				slot.holdres = meins.holdres
				Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
				break
			elif slot.holdres != null:
				if slot.holdres.kartenname == meins.holdres.kartenname:
					Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
					print("is gleich")
					break
	
	if meins.holdres.kartentyp == "Ability":
		abilityone.holdres = meins.holdres
		abilityone.texture_normal = meins.holdres.kartenbild
	
	if meins.holdres.kartentyp == "Upgrade":
		print("is ein upgrade")
	
	if meins.holdres.kartentyp == "Spezial":
		if meins.holdres.kartenname == "zufallability":
			spezialwahlupgrade = true
			kartenchoose()
			return
	
	Base.emit_signal("updateinventar")
	
	karten.visible = false
	Base.kartenauswahl = false
	kartenbutton.visible = false
	
	
	
	pass


func _on_buttonfour_pressed() -> void:
	
	var meins = karteone_4
	
	if meins.holdres.kartentyp == "Turm":
		for slot in inventar:
			if slot.holdres == null:
				slot.holdres = meins.holdres
				Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
				break
			elif slot.holdres != null:
				if slot.holdres.kartenname == meins.holdres.kartenname:
					Base.basictower[slot.holdres.kartenname].gebaut += meins.holdres.toweranzahl
					print("is gleich")
					break
	
	if meins.holdres.kartentyp == "Ability":
		abilityone.holdres = meins.holdres
		abilityone.texture_normal = meins.holdres.kartenbild
	
	if meins.holdres.kartentyp == "Upgrade":
		print("is ein upgrade")
	
	
	if meins.holdres.kartentyp == "Spezial":
		if meins.holdres.kartenname == "zufallability":
			spezialwahlupgrade = true
			kartenchoose()
			return
	
	Base.emit_signal("updateinventar")
	
	karten.visible = false
	Base.kartenauswahl = false
	kartenbutton.visible = false
	
	
	pass


func _on_kartenbutton_pressed() -> void:
	
	karten.visible = !karten.visible
	
	pass
