extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var depth = 0
var max_depth = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_depth(depth, max_depth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_modulation_color_for_depth(depth_, max_depth):
	var scaled=1.0-depth_/max_depth
	#print(str(depth_)+" "+str(scaled))
	return Color(scaled,scaled,scaled)
	
func set_depth(depth_, max_depth):
	$background_mockup.modulate=create_modulation_color_for_depth(depth_, max_depth)