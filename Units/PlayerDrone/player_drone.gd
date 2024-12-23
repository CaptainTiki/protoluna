class_name Player_Drone extends Actor

@onready var animation_player = $AnimationPlayer
@onready var drone_sprite: Sprite2D = $DroneSprite

@export var speed: float = 200.0 #speed of the drone movement
@export var hover_height: float = 600.0
@export var hover_amplitude: float = 16.0
@export var hover_speed: float = 2.0

var hover_timer: float = 0.0
var facingright : bool= true

func _init() -> void:
	add_to_group("mobile")
	add_to_group("friendly")

func _ready()-> void:
	animation_player.play("Flame_On")

	

func _process(_delta: float) -> void:
	if velocity.x > 0 and facingright:
		drone_sprite.flip_h = false  # Ensure facing right.
	elif velocity.x < 0 and !facingright:
		drone_sprite.flip_h = true # Ensure facing left.

func _physics_process(delta):
	if position.y > 624:
		velocity.y = -1 * delta
		
	hover_timer += delta*hover_speed
	var hover_offset = sin(hover_timer) * hover_amplitude / 2.0
	global_position.y = hover_height + hover_offset

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		if direction < 0:
			facingright = false
		else:
			facingright = true
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
