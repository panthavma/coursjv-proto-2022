extends Area2D

var vitesse = 0.0
var direction = Vector2(1,0)
var perso = null
var degats = 100

func _ready():
	connect("body_entered", self, "on_body_entered")

func _physics_process(delta):
	global_translate(vitesse*direction*delta)

func on_body_entered(body):
	if(perso != null and body == perso):
		return
	if(body.has_method("PrendreCoup")):
		body.PrendreCoup(degats)
	queue_free()
