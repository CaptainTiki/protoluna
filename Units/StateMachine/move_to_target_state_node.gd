class_name MoveToTargetStateNode extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "wander"

@export var track_target_time_min : float = 0.5
@export var track_target_time_max : float = 2.0

@export var success_exit_state : StateNode #attack 
@export var fail_exit_state : StateNode #go back to searching

var exit_state : StateNode
var timer : float = 0.0
var destination_x: float = 0.0

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = true
	timer = randf_range(track_target_time_min, track_target_time_max)

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	state_exit_signal.emit()
	pass

func _process(delta) -> void:
	timer -= delta
	if actor.attackTarget and timer >= 0:
		var distance = actor.global_position.distance_to(actor.attackTarget.global_position)
		if distance > actor.attack_range:
			actor.is_moving = true
			move_to_target(delta)
		else:
			print("found target, attacking!")
			exit_state = success_exit_state
			state_exit_signal.emit()
	else:
		print("failed to find target, searching!")
		exit_state = fail_exit_state
		state_exit_signal.emit()
		pass
	pass

func _physics_process(delta: float) -> void:
	if actor.is_moving:
		var accel : float = move_toward(actor.velocity.length(), actor.max_speed, actor.acceleration * delta)
		actor.velocity = Vector2.RIGHT * accel * actor.move_direction
	else: #decelerate to 0
		#var accel : float = move_toward(actor.velocity.length(), 0, actor.acceleration * delta)
		actor.velocity = Vector2.RIGHT  * actor.move_direction
	
	#in case we're so low we can't see movemtn - just make it static
	if actor.velocity.length() < 0.1:
		actor.velocity = Vector2.ZERO
	
	# Add the gravity.
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity()
	
	actor.move_and_slide()
	pass

func move_to_target(_delta: float) -> void:
	#set move direction here
	if destination_x == 0.0:
		destination_x = pick_random_x_in_collider()
	
	actor.move_direction = Vector2(destination_x - actor.global_position.x, 0).normalized().x
	
	if abs(actor.global_position.x - destination_x) < actor.attack_range:
		destination_x = 0.0
	pass

func pick_random_x_in_collider() -> float:
	var target_collider = actor.attackTarget.get_node("CollisionShape2D")
	if target_collider is CollisionShape2D:
		var shape = target_collider.shape
		if shape is RectangleShape2D:
			var rect = shape.extents
			return target_collider.global_position.x + randf() * rect.x * 2 - rect.x
		elif shape is CapsuleShape2D:
			var radius = shape.radius
			#check to see if its rotated (for mobile units that are wider than tall)
			var is_rotated: bool = target_collider.global_rotation_degrees != 0
			if is_rotated:
				#capsule rotated - use the height instead of radius
				return target_collider.global_position.x + randf() * shape.height - shape.height / 2
			else: #not rotated - use radius as x coord
				return target_collider.global_position.x + randf() * radius * 2 - radius
	return target_collider.global_position.x #default to center - if we missed something
