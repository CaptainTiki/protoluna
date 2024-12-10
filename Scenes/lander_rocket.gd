extends Node2D

@export var deploy_scene: PackedScene #scene to deploy once landed
@export var deploy_position: Vector2 #where our rocket is landing to deploy a building
@export var start_position: Vector2 #offscreen location that we save when we instantiate
@export var landing_speed: float = 5.0 # Adjust for faster or slower initial movement
@export var deceleration: float = 0.1 # Adjust for slower or faster deceleration

var current_position : Vector2
var is_moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize starting position
	current_position = start_position
	position = start_position
	
	if position == deploy_position:
		start_liftoff()
	else:
		start_landing() 

func start_liftoff() -> void:
	pass

func start_landing() -> void:
	is_moving = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if is_moving:
		#calculate the distance to the target
		var distance = deploy_position - current_position
		#stop moving if we're close enough
		if distance.length() <= 2.5: #larger than the step check below 
			position = deploy_position
			is_moving = false
			on_landing_complete()
			return
		
		#adjust speed based on distance
		var step = distance * deceleration * delta * landing_speed
		if step.y < 2:
			step.y = 2
		if step.x > 0 && step.x < 2:
			step.x = 2
		current_position += step
		
		#update the position of the rocket
		position = current_position

func on_landing_complete():
	print("Landing Complete")
	#trigger game mechanism to spawn building
