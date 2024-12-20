extends Camera2D

@export var center_offset: float = 25 #offset to keep player within center
@export var lerp_speed: float = 5.0 #how fast we lerp the camera to center
@export var height_offset: float = 400

var target_position: Vector2 = Vector2(0,height_offset)

func _ready():
	global_position = target_position
	pass

func _process(delta):
	_update_camera(delta)
	pass

func _update_camera(delta: float) -> void:
	var player_position = GameManager.get_player_position()
	#check if we're outside the offset
	if abs_position_difference(player_position.x, global_position.x) > center_offset:
		#set the target position to the drone's position, and keep the Y axis same
		#target_position = Vector2(player_position.x, player_position.y)
		target_position = Vector2(player_position.x, height_offset)
	
	#interpolate the camer position
	global_position = global_position.lerp(target_position, lerp_speed * delta)


func abs_position_difference(a: float, b: float) -> float:
	return abs(a-b)
