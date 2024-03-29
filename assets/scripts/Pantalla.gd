extends Node2D

var time = 0.0
var time_to_spawn = 2
var fish_scene = null


var depth_position = 0
const depth_fish = 4

var swordfish_appeared = false

export var fish_scenes={"Cualquiera":preload("res://scenes/Fish.tscn"),
	"FlyerFish":preload("res://assets/scenes/prefabs/characters/FishFlyer.tscn"),
	"SwordFish":preload("res://assets/scenes/prefabs/characters/FishSword.tscn"), 
	"Abysal":preload("res://assets/scenes/prefabs/characters/FishAbysal.tscn"),
	"JellyFish":preload("res://assets/scenes/prefabs/characters/FishJelly.tscn"),
	"Mermaid":preload("res://assets/scenes/prefabs/characters/FishMermaid.tscn"),
	"Octopus":preload("res://assets/scenes/prefabs/characters/FishOctopus.tscn")}

var depth_index=0
var depths=[170,1500]
var depth_length = depths.size()
var species=["FlyerFish","SwordFish", "Abysal", "JellyFish", "Mermaid", "Octopus"]
var probabilities_vs_depth=[{"FlyerFish":0.8,"SwordFish":0.0,"Abysal":0.00, "JellyFish":0.13,"Mermaid":0.02, "Octopus":0.05},
	{"FlyerFish":0.6,"SwordFish":0.0,"Abysal":0.00, "JellyFish":0.33,"Mermaid":0.02, "Octopus":0.05},
	{"FlyerFish":0.4,"SwordFish":0.05,"Abysal":0.05, "JellyFish":0.3,"Mermaid":0.05, "Octopus":0.05},
	{"FlyerFish":0.3,"SwordFish":0.2,"Abysal":0.3, "JellyFish":0.1,"Mermaid":0.15, "Octopus":0.1},
	{"FlyerFish":0.0,"SwordFish":0.5,"Abysal":0.85, "JellyFish":0.0,"Mermaid":0.00, "Octopus":0.15},]

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

	for j in range(species.size()):
			#print("-> "+str(dict[species[j]]))
			if (numrand<=dict[species[j]] && !found):
				newfish(species[j])
				found=true
	
func newfish(type_fish):
	var fish = get_fish_instance(type_fish)
	
	#The case of sword fish is made in particular...
	if (type_fish=="SwordFish"):
		#If it is the first time it appears, play the music
		if (not swordfish_appeared):
			$musicplayer.stop()
			$musicplayer.stream = preload("res://music/elpez_aparece.ogg")
			$musicplayer.play()
			swordfish_appeared = true
		#If not, the function ends here, doing nothing
		else:
			return
	
	#Generate a fish in a random position
	var randposition = randf()
	if (randposition <= 0.5):
		fish.position = Vector2(-400, $Hook.position.y+400)
	else:
		fish.position = Vector2(400, $Hook.position.y+400)
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
	
	if time>=time_to_spawn:
		depth_position = round($Hook.position.y/level_range)
		newfish_by_depth(depth_position)
		
		if (depth_position > depth_fish):
			$musicplayer.stop()
			$musicplayer.stream = preload("res://music/abisal.ogg")
			$musicplayer.play()
		
		time=0.0
		if (depth_index < depth_length and depths[depth_index] < $Hook.position.y):
		#	print("--------> siguiente nivel ")
			depth_index = depth_index+1
			
		#print($Hook.position.y)

#Call this function when the musicplayer stops playing a song
func _on_musicplayer_finished():
	#If the stream path contains "pez", then play "abisal".
	#In this way, the "abisal" theme is played as soon as The Fish
	#theme finishes
	if ($musicplayer.stream.resource_path.find("pez")):
		$musicplayer.stop()
		$musicplayer.stream = preload("res://music/abisal.ogg")
		$musicplayer.play()


