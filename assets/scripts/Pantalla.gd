extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vel = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$AnimationPlayer.play("scroll")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position.y += vel
	pass
