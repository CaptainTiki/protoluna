class_name WorkerDrone extends Actor

@onready var sprite = $Sprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#sprite.scale.x = -sign(velocity.x)
	#if sprite.scale.x == 0.0 : sprite.scale.x = 1.0
	#if sprite.scale.y == 0.0 : sprite.scale.y = 1.0
	
	move_and_slide()
