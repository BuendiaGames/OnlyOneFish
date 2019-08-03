extends Area2D

var speed = 30.0
var direction = Vector2(0.0, 0.0)
var time = 0.0

# Fishes properties
var min_speed = 30.0
var speed_range = 30.0
var acceleration = 20.0
var is_the_fish = false


func setspeed():
	var randomnumber = randf()
	speed = min_speed + randomnumber*speed_range
	pass
	
func setdirection():
	if(self.position.x < 0):
		direction = Vector2(1.0, 0.0)
	else:
		direction = Vector2(-1.0, 0.0)
	
	pass
	
# Checks if the fish you have is The Fish
func is_this_fish_the_fish():
	return is_the_fish

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Initialize fish properties
func init(fish_type):
	if (fish_type == "Cualquiera"):
		min_speed = 30.0
		speed_range = 30.0
		acceleration = 20.0
		is_the_fish = false
		# FIXME It is necessary to adjust the collision shape size
		# FIXME It is necessary to change the sprite to the type of fish
		# FIXME Here we distinguish the different types of fishes on an if/else
	setspeed()
	setdirection()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	init("Cualquiera") # FIXME Borrar esto al tener la escena principal
	randomize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	# Make fish move
	self.position += (speed+sin(time)*acceleration)*direction*delta 
	
	# Make fishes come back to the screen
	if (self.position.x <= -400):
		direction = Vector2(1.0, 0.0)
		$Sprite.set_flip_h(true)
	elif (self.position.x >= 400): 
		$Sprite.set_flip_h(false)
		direction = Vector2(-1.0, 0.0)
	pass


func _on_VisibilityNotifier2D_screen_exited():
	print("Pez fuera!")
	queue_free()
