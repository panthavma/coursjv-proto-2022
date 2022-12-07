extends "Arme.gd"

export var PREFAB_TIR = "res://armes/pistolet/Balle.tscn"

export var VITESSE_TIR = 600.0
export var FREQ_TIR = 3.0
export var DEGATS = 100

var _prefabTir
func _ready():
	_prefabTir = load(PREFAB_TIR)

var _tempsCooldown = 0.0
func Gestion(perso, delta):
	var inputTir = Input.is_action_pressed(perso.playerInputPrefix+"a")
	
	if(DoitTirer(perso, inputTir, delta)):
		Tir(perso)

func DoitTirer(perso, inputTir, delta):
	if(_tempsCooldown <= 0):
		if(inputTir):
			_tempsCooldown = 1.0/FREQ_TIR
		return inputTir
	else:
		_tempsCooldown -= delta
		return false

func Tir(perso):
	var tir = _prefabTir.instance()
	tir.set_position(perso.get_position())
	tir.vitesse = VITESSE_TIR
	tir.direction = perso._direction
	tir.perso = perso
	tir.degats = DEGATS
	$"../..".add_child(tir)
