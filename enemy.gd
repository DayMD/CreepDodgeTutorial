extends RigidBody2D

export var min_speed = 50
export var max_speed = 150


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = enemy_types[randi() % enemy_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
