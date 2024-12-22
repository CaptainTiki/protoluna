class_name AttackFriendlyState extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var move_animation_name : String = "walk"
@export var attack_animation_name : String = "attack"

@export var search_time_min : float = 0.5
@export var search_time_max : float = 2.0

@export var success_exit_state : StateNode

var exit_state : StateNode

var destination_x: float = 0.0
var is_attacking: bool = false

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(move_animation_name)
	actor.is_moving = false
	is_attacking = false

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	state_exit.emit()
	pass

func _process(delta) -> void:
	if actor.attackTarget && actor.attackTarget is Node2D:
		var distance = actor.attackTarget.global_position.distance_to(actor.attackTarget.global_position)
		if distance > actor.attack_range:
			move_to_target(delta)
			if not animator.playing(move_animation_name):
				animator.play(move_animation_name)
		else:
			if not is_attacking:
				perform_attack()
			if not animator.playing(attack_animation_name):
				animator.play(move_animation_name)
	else:
		print("no target found")
		pass
	pass

func perform_attack():
	is_attacking = true
	
	# Play attack animation
	animator.play(attack_animation_name)
	
	if actor.attackTarget.has_method("take_damage"):
		actor.attackTarget.take_damage(actor.attack_damage)
	
	await animator.animation_finished
	is_attacking = false
	exit_state.emit()

func _physics_process(delta: float) -> void:
	if actor.is_moving:
		var accel : float = move_toward(actor.velocity.length(), actor.max_speed, actor.acceleration * delta)
		actor.velocity = Vector2.RIGHT * accel * actor.move_direction
	else: #decelerate to 0
		#var accel : float = move_toward(velocity.length(), 0, acceleration * delta)
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
	
	if abs(actor.global_position.x - destination_x) < 1.0:
		destination_x = 0.0
	pass

func pick_random_x_in_collider() -> float:
	var target = actor.attacktarget.getchild("CollisionShape2D")
	if target is CollisionShape2D:
		var shape = target.shape
		if shape is RectangleShape2D:
			var rect = shape.extents
			return target.global_position.x + randf() * rect.x * 2 - rect.x
		elif shape is CapsuleShape2D:
			var radius = shape.radius
			#check to see if its rotated (for mobile units that are wider than tall)
			var is_rotated: bool = target.global_rotation_degrees != 0
			if is_rotated:
				#capsule rotated - use the height instead of radius
				return target.global_position.x + randf() * shape.height - shape.height / 2
			else: #not rotated - use radius as x coord
				return target.global_position.x + randf() * radius * 2 - radius
	return target.global_position.x #default to center - if we missed something
