extends TextureRect

var ScManager = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/SceneManager")
	set_process(true)

#Check button press
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		ScManager.goto_scene("res://scenes/credits.tscn")
	pass




func _on_Button_pressed():
	ScManager.goto_scene("res://scenes/credits.tscn")
	pass # Replace with function body.
