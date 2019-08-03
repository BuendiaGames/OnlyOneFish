extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vel = 0.70
var depth = 0.0
var time = 0.0
var fish_scene = null

export var fish_scenes={"Cualquiera":preload("res://scenes/Fish.tscn"), "SwordFish":preload("res://assets/scenes/prefabs/characters/FishSword.tscn"), "Abysal":preload("res://assets/scenes/prefabs/characters/FishAbysal.tscn")}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	fish_scene = preload("res://scenes/Fish.tscn")
	pass

func newfish(type_fish):
	var fish = get_fish_instance(type_fish)
	
	var randposition = randf()
	if (randposition <= 0.5):
		fish.position = Vector2(-400, $Camera2D.position.y+250)
	else:
		fish.position = Vector2(400, $Camera2D.position.y+250)
	fish.init(type_fish)
	add_child(fish)
	
	pass
	
	# Obtain an insance of a fish
func get_fish_instance(type_fish):
	var instance=fish_scenes[type_fish].instance()
	return instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position.y += vel
	
	time += delta
	
	var numrand = randf()
	if (numrand <= 0.25 and time >= 3):
		newfish("SwordFish")
		time = 0
	elif(numrand <= 0.5 and time >= 3):
		newfish("Abysal")
		time = 0
	pass
