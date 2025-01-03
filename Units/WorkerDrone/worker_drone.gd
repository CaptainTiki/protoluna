class_name WorkerDrone extends Actor

@onready var state_machine = $StateMachine

var is_idle = true
var build_request_target : Building

func _init():
	super._init()
	add_to_group("friendly")

func _ready() -> void:
	GameManager.add_debug_info(self.name, str(velocity))
	GameManager.connect("building_request",_on_build_request)
	pass

func _process(_delta):
	
	if velocity.x > 0 and move_direction > 0:
		_flip_all_sprites(false)  # Ensure facing right.
	elif velocity.x < 0 and move_direction < 0:
		_flip_all_sprites(true) # Ensure facing left.
	else:
		
		pass

func _physics_process(delta):
	if is_moving:
		var accel : float = move_toward(velocity.length(), max_speed, acceleration * delta)
		velocity = Vector2.RIGHT * accel * move_direction
	else: #decelerate to 0
		#var accel : float = move_toward(velocity.length(), 0, acceleration * delta)
		velocity = Vector2.RIGHT  * move_direction
	
	#in case we're so low we can't see movemtn - just make it static
	if velocity.length() < 0.1:
		velocity = Vector2.ZERO
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity()
	
	move_and_slide()

func _on_build_request() -> void:
	if is_idle:
		is_idle = false
		#change state to working
	pass
	
func has_build_request() -> bool:
	if not build_request_target == null:
		return true
	return false
