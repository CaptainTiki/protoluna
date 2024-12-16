class_name Player_Drone extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

@export var speed: float = 200.0 #speed of the drone movement
@export var hover_height: float = 600.0
@export var hover_amplitude: float = 16.0
@export var hover_speed: float = 2.0

var hover_timer: float = 0.0

func _ready()-> void:
	animation_player.play("Flame_On")



func _physics_process(delta):
	if position.y > 624:
		velocity.y = -1 * delta
		
	hover_timer += delta*hover_speed
	var hover_offset = sin(hover_timer) * hover_amplitude / 2.0
	global_position.y = hover_height + hover_offset

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
