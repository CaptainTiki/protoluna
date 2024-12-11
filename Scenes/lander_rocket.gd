extends Node2D

@export var deploy_scene: PackedScene #scene to deploy once landed
@export var deploy_position: Vector2 #where our rocket is landing to deploy a building
@export var start_position: Vector2 #offscreen location that we save when we instantiate
@export var landing_speed: float = 5.0 # Adjust for faster or slower initial movement
@export var deceleration: float = 0.1 # Adjust for slower or faster deceleration

@onready var animation_thruster = $AnimationThruster
@onready var animation_fins = $AnimationFins
@onready var animation_legs = $AnimationLegs
@onready var animation_body = $AnimationBody

var current_position : Vector2
var is_moving: bool = false
var landing = true
var legsdeployed = false
var finsdeployed = true
var bodysplit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_thruster.play("RESET")
	animation_fins.play("RESET")
	animation_legs.play("RESET")
	animation_body.play("RESET")
	#initialize starting position
	current_position = start_position
	position = start_position
	
	if position == deploy_position:
		start_liftoff()
		animation_thruster.play("thrusting")
	else:
		start_landing() 
		animation_thruster.play("thrusting")

func start_liftoff() -> void:
	pass

func start_landing() -> void:
	is_moving = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	if is_moving:
		#calculate the distance to the target
		var distance = deploy_position - current_position
		#check to see if we need to do any other animations	
		if distance.length() <= 75:
			if landing:
				if legsdeployed == false:
					animation_legs.play("deploy")
					animation_fins.play("retract")
					finsdeployed = false
					legsdeployed = true
			else:
				if legsdeployed == true:
					animation_legs.play("retract")
					animation_fins.play("deploy")
					legsdeployed = false
					finsdeployed = true
			pass
		#stop moving if we're close enough
		if distance.length() <= 2.5: #larger than the step check below 
			position = deploy_position
			if is_moving == true:
				animation_body.play("deploy")
				is_moving = false
			animation_thruster.play("off")
			if animation_body.current_animation == "deploy" && animation_body.is_playing() == false:
				bodysplit = true
			if legsdeployed && finsdeployed == false && bodysplit == true:
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
	elif is_moving == false:
		if landing:
			pass
		pass
		
func on_landing_complete():
	print("Landing Complete")
	#trigger game mechanism to spawn building
