extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var depth = 0.0
var time = 0.0
var fish_scene = null

export var fish_scenes={"Cualquiera":preload("res://scenes/Fish.tscn"), "FlyerFish":preload("res://assets/scenes/prefabs/characters/FishFlyer.tscn"), "SwordFish":preload("res://assets/scenes/prefabs/characters/FishSword.tscn"), "Abysal":preload("res://assets/scenes/prefabs/characters/FishAbysal.tscn")}


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	fish_scene = preload("res://scenes/Fish.tscn")
	pass

func newfish_by_depth(depth):
	
		
	pass
	
func newfish(type_fish):
	var fish = get_fish_instance(type_fish)
	
	var randposition = randf()
	if (randposition <= 0.5):
		fish.position = Vector2(-400, $Hook.position.y+250)
	else:
		fish.position = Vector2(400, $Hook.position.y+250)
	fish.init(type_fish)
	add_child(fish)
	
	pass
	
	# Obtain an insance of a fish
func get_fish_instance(type_fish):
	var instance=fish_scenes[type_fish].instance()
	return instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	time += delta
	
	if time>=3:
		var numrand = randf()
		if (numrand <= 0.25):
			newfish("SwordFish")
		elif(numrand <= 0.5):
			newfish("FlyerFish")
		elif(numrand <= 0.75):
			newfish("Abysal")
		pass
		time=0
		print($Hook.position.y)
