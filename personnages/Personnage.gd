extends KinematicBody2D

export var playerInputPrefix = "p1_"

var VITESSE_COURSE = 140.0
var ACCEL_COURSE = 550.0
var PV_MAX = 1200

var _vitesse = Vector2()
var _direction = Vector2(1,0)
var _pv = PV_MAX

onready var arme = $Pistolet

func _physics_process(delta):
	# Lecture des entrées
	var inputMouvement = Vector2(
		Input.get_action_strength(playerInputPrefix+"right") - Input.get_action_strength(playerInputPrefix+"left"),
		Input.get_action_strength(playerInputPrefix+"down") - Input.get_action_strength(playerInputPrefix+"up"))
	
	if(inputMouvement.length_squared() > 1):
		inputMouvement = inputMouvement.normalized()
	if(inputMouvement.length_squared() > 0):
		_direction = inputMouvement.normalized()
	
	var vitesseCible = inputMouvement * VITESSE_COURSE
	_vitesse = _vitesse.move_toward(vitesseCible, ACCEL_COURSE * delta)
	
	if(_vitesse.length_squared() > VITESSE_COURSE*VITESSE_COURSE):
		_vitesse = _vitesse.normalized() * VITESSE_COURSE
	
	move_and_slide(_vitesse)
	
	arme.Gestion(self, delta)

func PrendreCoup(degats):
	_pv -= degats
