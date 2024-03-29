extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pescado = false
var win = false
var vel = 30
var maxvel = 70
var acel = 25
var Scmanager = null
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Scmanager = get_node("/root/SceneManager")
	$Sprite/AnimationPlayer2.play("mov")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!pescado):
		self.position.y += vel*delta
	elif (pescado):
		self.position.y -= vel*delta
	vel = min(vel+acel*delta, maxvel)
	
	e_pressed()
	
	if (pescado):
		time += delta
		if (time >= 4 and win):
			Scmanager.goto_scene("res://scenes/wonScene.tscn")
		elif (time >= 4 and not win):
			Scmanager.goto_scene("res://scenes/loseScene.tscn")
	pass

func e_pressed():
	if (Input.is_action_just_pressed("ui_accept") and self.position.y >= 0 and !pescado):
		vel = -40.0
	

func _on_Hook_area_entered(area):
	var pez = area
	pez.caught(self.position.x)
	pescado = true
	vel = 50.0
	acel = 0.0
	$AnimationPlayer.play("FadeOUt")
	
	if (pez.is_this_fish_the_fish()):
		win = true
	pass # Replace with function body.
