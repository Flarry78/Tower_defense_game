extends Node
class_name mainbase


### tower stacken jetzt, jetzt abziehen beim bauen und ability slot fixen

### wenn tower im inventar genommen werden mit linkslick und dann ein andere tower angegkliuckt wird,
### dann ist der ghosttower noch der alte aber es wird der 2te gewählte tower geplaced

### wann welche upgrades kommen und wenn nicht dann keine karten anzeigen

### karten dem pool hinzufügen wenn zb tower xy genommen wurde

### tickschaden bei fähigkeiten überdenken oder wie das gemacht wird

### alle stats überarbeiten, fähigkeiten dictionary stats etc

### bei der endpunktzahl kann man escape drücken und es läuft wieder weuiter

### fähigkeit cooldown oder aufladungen

### bug wo tower manchma schneller schießen weil neue gegner in die area kommen 
### obwohl der reload timer noch laufen sollte


### Alle globalen stats
var leben : int = 30
var runde : int = 0
var finalrunde : int = 16
var punktzahl : int = 0


### Alles mit den Wellen
@warning_ignore("unused_signal")
signal startewelle

var wellelauft : bool = false
var gegnergekommen : bool = false

var finalphase : bool = false

var kartenauswahl : bool = false


### Alles mit bauen

var alleaktiventower : Array[Node2D] = []

var besetztefelder : Dictionary = {}

@warning_ignore("unused_signal")
signal bauplanturm(baudata)


### Anzeigen
@warning_ignore("unused_signal")
signal updatehud


@warning_ignore("unused_signal")
signal zeigekarten


func _ready() -> void:
	randomize()
	addemaps()
	addemobs()
	erstelletimer()
	
	pass




var abilitypool : Array = ["Kochsalz","Artillery","Desinfektionspray"]

var towerpool : Array = ["Sniperauge","Basetower","Fleischtower","Lasershotgun",]

var upgradepool : Array = ["lebenplus", "plusonepierce", "plustwopierce", "rangedouble",
"upfastlaser", "upfastfleisch", "upplusfleisch", "uppluslaser"]

var towerkartenanzahl : int = 3
var abilitykartenanzahl : int = 2
var upgradeskartenanzahl : int = 4



var towerwahl : Array = [1, 3, 5]
var abilitywahl : Array = [2, 6, 10]
var upgradewahl : Array = [4, 7, 8, 9]
var specialwahl : Array = [11 , 12, 15]
var endwahl : Array = [16]

signal dottick
var dot_timer: Timer

func erstelletimer() -> void:
	
	dot_timer = Timer.new()
	dot_timer.wait_time = 0.2
	dot_timer.autostart = true
	dot_timer.one_shot = false
	add_child(dot_timer)
	dot_timer.connect("timeout", Callable(self, "_on_dot_tick"))
	
	pass

func _on_dot_tick() -> void:
	
	emit_signal("dottick")
	
	pass




func fullreset() -> void:
	
	leben = 30
	runde = 0
	finalrunde = 30
	punktzahl = 0
	wellelauft = false
	alleaktiventower.clear()
	besetztefelder.clear()
	
	
	self.emit_signal("updatehud")
	
	pass


var rndmap : Array[String] = []
@onready var allemaps : Dictionary = {
	
	"maptileone" : load("res://maps/maptileone.tscn")
	
	
}

var rndmob : Array[String] = []
@onready var allegegner : Dictionary = {
	
	"gegnereinsbakterie" : load("res://enemys/enemyone.tscn"),
	
	"gegnerzweiflesheating" : load("res://enemys/enemytwo.tscn"),
	
	#"boss" : load("res://enemys/boss.tscn")
	
	
	
}


func addemobs() -> void:
	
	
	for map in allegegner:
		rndmob.append(map)
	
	pass

var currentmap : String = ""
var takecurrent : bool = false

func addemaps() -> String:
	
	for map in allemaps:
		rndmap.append(map)
	
	var getmap = rndmap.pick_random()
	currentmap = getmap
	
	return getmap


var allupgrades: Dictionary = {
	"lebenplus": {"respfad" : load("res://reso/upleben.tres"),"textfeld" : "Erhöhe deine Leben um +zahl+."},
	
	"plusonepierce": {"respfad" : load("res://reso/uponepierce.tres"),"textfeld" : "Geschosse durchdringen den ersten Gegner."},
	
	"plustwopierce": {"respfad" : load("res://reso/uptwopierce.tres"),"textfeld" : "Geschosse durchdringen die ersten 2 Gegner."},
	
	"rangedouble": {"respfad" : load("res://reso/uprangedouble.tres"),"textfeld" : "Verdoppelt die Range aller Tower."},
	
	"upfastlaser": {"respfad" : load("res://reso/uplaserfast.tres"),"textfeld" : "Lasertürme schießen schneller."},
	
	"upfastfleisch": {"respfad" : load("res://reso/upfleischfast.tres"),"textfeld" : "Fleischtürme schießen schneller."},
	
	"upplusfleisch": {"respfad" : load("res://reso/upfleischplus.tres"),"textfeld" : "Alle Fleischtürme machen mehr Schaden"},
	
	"uppluslaser": {"respfad" : load("res://reso/uplaserplus.tres"),"textfeld" : "Alle Lasertürme machen mehr Schaden"},
}



var basictower: Dictionary = {
	"Basetower": {"schaden" : 50,"feuerrate" : 1,"maxrange" : 200, "respfad" : load("res://reso/basetower.tres"),
	"textfeld" : "Standardtower mit Lasergeschossen",
	"pfad" : load("res://tower/basetower.tscn")},
	
	"Fleischtower": {"schaden" : 20,"feuerrate" : 0.6,"maxrange" : 200, "respfad" : load("res://reso/fleischtowerone.tres"),
	"textfeld" : "Schneller Turm mit Piercing Geschossen",
	"pfad" : load("res://tower/fleischtower.tscn")},
	
	"Lasershotgun": {"schaden" : 40,"feuerrate" : 0.8,"maxrange" : 100, "respfad" : load("res://reso/shotguntower.tres"),
	"textfeld" : "Schiest in 4 Richtungen einen Laser mit weniger Reichweite",
	"pfad" : load("res://tower/lasershotgun.tscn")},
	
	"Sniperauge": {"schaden" : 100,"feuerrate" : 2,"maxrange" : 500, "respfad" : load("res://reso/sniperaugeres.tres"),
	"textfeld" : "Sniperturm mit hoher Reichweite und Lasergeschosse",
	"pfad" : load("res://tower/sniperauge.tscn")}
	
	
	
}


var ability : Dictionary = {
	"Artillery": {"schaden" : 70,"dauer" : 7, "respfad" : load("res://reso/atillery.tres"),
	"textfeld" : "Artilleryfeuer mit zufälligen Einschlägen."},
	
	"Desinfektionspray": {"schaden" : 20,"dauer" : 10, "respfad" : load("res://reso/desinfektionspray.tres"),
	"textfeld" : "Eine Gaswolke die kontinuierlich Schaden verursacht."},
	
	"Kochsalz": {"schaden" : 10,"dauer" : 15, "respfad" : load("res://reso/salz.tres"),
	"textfeld" : "Eine Kochsalzlösung die Gegner kontinuierlich Schaden zufügt und sie slowt."},
	
	
	
}
