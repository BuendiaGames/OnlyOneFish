extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var n_niveles=10
var tam_texture = 163

# Called when the node enters the scene tree for the first time.
func _ready():
	# hay que cambiarlo!!!!!!!!!!!
	var sea_level = preload("res://assets/scenes/prefabs/objects/BackgroundTile.tscn") 
	for i in range(n_niveles):
		var node = sea_level.instance()
		add_child(node)
		node.position.y=(i+1)*tam_texture
		node.z_index=-(1+i)
		node.set_depth(i, n_niveles*1.0)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
