extends TextureRect

var ScManager = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/SceneManager")
	set_process(true)

#Check button press
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		ScManager.goto_scene("res://assets/scenes/levels/Pantalla.tscn")
	pass

func _on_Start_pressed():
	ScManager.goto_scene("res://assets/scenes/levels/Pantalla.tscn")
	pass # Replace with function body.
