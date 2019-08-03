extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var depth=0
export var max_depth=10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_depth(depth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_modulation_color_for_depth(depth_):
	var scaled=1.0-depth_/max_depth
	print(str(depth_)+" "+str(scaled))
	return Color(scaled,scaled,scaled)
	
func set_depth(depth_):
	$background_mockup.modulate=create_modulation_color_for_depth(depth_)