extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pescado = false
var win = false
var vel = 30
var maxvel = 70
var acel = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!pescado):
		self.position.y += vel*delta
	elif (pescado):
		self.position.y -= vel*delta
	vel = min(vel+acel*delta, maxvel)
	e_pressed()
	pass
	
	
	

func e_pressed():
	if (Input.is_action_just_pressed("ui_accept") and !pescado):
		vel = -40.0
	

func _on_Hook_area_entered(area):
	var pez = area
	pez.caught()
	pescado = true
	vel = 50.0
	acel = 0.0
	
	if (pez.is_this_fish_the_fish()):
		win = true
	pass # Replace with function body.
