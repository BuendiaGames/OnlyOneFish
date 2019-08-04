extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var depth = 0.0
var time = 0.0
var fish_scene = null

var is_at_abyss = false
var depth_position = 0
const depth_fish = 4

export var fish_scenes={"Cualquiera":preload("res://scenes/Fish.tscn"),
	"FlyerFish":preload("res://assets/scenes/prefabs/characters/FishFlyer.tscn"),
	"SwordFish":preload("res://assets/scenes/prefabs/characters/FishSword.tscn"), 
	"Abysal":preload("res://assets/scenes/prefabs/characters/FishAbysal.tscn"),
	"JellyFish":preload("res://assets/scenes/prefabs/characters/FishJelly.tscn"),
	"Mermaid":preload("res://assets/scenes/prefabs/characters/FishMermaid.tscn")}

var depth_index=0
var depths=[170,1500]
var depth_length = depths.size()
var species=["FlyerFish","SwordFish", "Abysal", "JellyFish", "Mermaid"]
var probabilities_vs_depth=[{"FlyerFish":0.8,"SwordFish":0.05,"Abysal":0.00, "JellyFish":0.13,"Mermaid":0.02},
	{"FlyerFish":0.6,"SwordFish":0.05,"Abysal":0.00, "JellyFish":0.33,"Mermaid":0.02},
	{"FlyerFish":0.4,"SwordFish":0.05,"Abysal":0.1, "JellyFish":0.3,"Mermaid":0.05},
	{"FlyerFish":0.3,"SwordFish":0.05,"Abysal":0.4, "JellyFish":0.1,"Mermaid":0.15},
	{"FlyerFish":0.0,"SwordFish":0.0,"Abysal":1.0, "JellyFish":0.0,"Mermaid":0.00},]

var level_range=1000

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	fish_scene = preload("res://scenes/Fish.tscn")
	recalculate_accumulative_probabilities()
	pass
	
func recalculate_accumulative_probabilities():
	for i in range(probabilities_vs_depth.size()):
		var total=0
		var acu=0
		var dict=probabilities_vs_depth[i]
		
		for j in dict.values():
			total=total+j
			
		for k in range(species.size()):
			dict[species[k]]=dict[species[k]]/total+acu
			acu=dict[species[k]]

func newfish_by_depth(depth_level):
	
	#print("Depth: "+str(depth_level))
	
	if (depth_level >= probabilities_vs_depth.size()):
		depth_level = probabilities_vs_depth.size()-1
	
	var dict=probabilities_vs_depth[depth_level]
	
	var numrand = randf()
	var found=false
	var aux_prob = 0.0
	#print(species.size())
	for j in range(species.size()):
			#print("-> "+str(dict[species[j]]))
			if (numrand<=dict[species[j]] && !found):
				newfish(species[j])
				found=true
	
func newfish(type_fish):
	var fish = get_fish_instance(type_fish)
	
	if (type_fish=="SwordFish"):
		$musicplayer.stop()
		$musicplayer.stream = preload("res://music/elpez_aparece.ogg")
		$musicplayer.play()
	
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
		depth_position = round($Hook.position.y/level_range)
		newfish_by_depth(depth_position)
		
		if (depth_position > depth_fish and not is_at_abyss):
			$musicplayer.stop()
			$musicplayer.stream = preload("res://music/abisal.ogg")
			$musicplayer.play()
			is_at_abyss = true
		
		time=0.0
		if (depth_index < depth_length and depths[depth_index] < $Hook.position.y):
		#	print("--------> siguiente nivel ")
			depth_index = depth_index+1
			
		#print($Hook.position.y)
