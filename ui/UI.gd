extends Control

var modeEntrainement = true
enum ETAT_JEU {
	CHOIX_PERSO, JEU, ECRAN_FIN
}

onready var p1 = $"../Personnage"
onready var p2 = $"../Personnage2"

var _etat = ETAT_JEU.JEU

func _ready():
	ChangerEtat(ETAT_JEU.JEU)

func _process(delta):
	if(_etat == ETAT_JEU.JEU):
		GameProcess(delta)
	elif(_etat == ETAT_JEU.CHOIX_PERSO):
		MenuChoix(delta)
	elif(_etat == ETAT_JEU.ECRAN_FIN):
		EcranVictoire(delta)

func GameProcess(delta):
	UpdatePlayer(p1, $p1)
	UpdatePlayer(p2, $p2)

func UpdatePlayer(perso, ui):
	ui.set_max(perso.PV_MAX)
	ui.set_value(perso._pv)

func ChangerEtat(etat):
	_etat = etat
	$ChoixArmes.set_visible(etat == ETAT_JEU.CHOIX_PERSO)
	$Victoire.set_visible(etat == ETAT_JEU.ECRAN_FIN)
	_tempsVictoire = 2.0
	

func MenuChoix(delta):
	pass

var _tempsVictoire
func EcranVictoire(delta):
	if(_tempsVictoire <= 0):
		ChangerEtat(ETAT_JEU.CHOIX_PERSO)
	_tempsVictoire -= delta
