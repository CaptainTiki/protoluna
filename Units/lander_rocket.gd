extends Node2D

@onready var animation_deploys: AnimationPlayer = $AnimationDeploys
@onready var animation_flame: AnimationPlayer = $AnimationFlame
@onready var timer: Timer = $Timer

@export var deploy_scene: PackedScene #scene to deploy when the rocket lands
@export var deploy_position: Vector2
@export var start_position: Vector2
@export var landing_speed: float = 5.0 # Adjust for faster/slower initial movement
@export var deceleration: float = 0.1 # Adjust for slower or faster deceleration

var stages : Array[String] = ["legs_deploy","fins_retract","body_split"]
var current_position: Vector2
var current_stage = 0

var landing = true
var deploying = false

func _ready() -> void:
	animation_flame.play("flame_on")

func _physics_process(delta: float) -> void:
	if landing:
		move_to_landing(delta)

func move_to_landing(delta) -> void:
	var distance = deploy_position - current_position
	# Stop landing if close enough
	if distance.length() < 3.0:
		position = deploy_position
		landing = false
		animation_flame.play("flame_off")
		play_next_stage()
		return
	
	if distance.length() < 75.0 && current_stage == 0:
		animation_deploys.play("legs_deploy")
		current_stage += 1
		return
	
	# Adjust speed based on the distance (slowing down as we approach)
	var step = distance * deceleration * delta * landing_speed
	
	if step.x <1 && step.x != 0:
		step.x = 1
	if step.y <1:
		step.y = 1
		
	current_position += step
	position = current_position

func play_next_stage() -> void:
	if current_stage < stages.size():
		animation_deploys.play(stages[current_stage])
		current_stage += 1 
	else:
		if animation_deploys.is_playing() == false:
			complete_deployment()
			pass

func _on_animation_deploys_animation_finished(anim_name: StringName) -> void:
		if landing == false:
			timer.start(0.1)

func _on_timer_timeout():
	if deploying:
		queue_free()
	else:
		play_next_stage()

func complete_deployment() -> void:
	if deploy_scene:
		timer.start(1)
		deploying = true
		var building : Node2D = deploy_scene.instantiate()
		get_parent().add_child(building)
		building.position = self.position
	else:
		print("Error deploying building, new node not assigned")
		queue_free()
	pass
	
	
