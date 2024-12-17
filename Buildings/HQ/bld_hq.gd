extends Building

var is_hovering  = false
var current_time: float = 0.0

var landingPadOffset : Vector2 = Vector2(192,-16)

func _ready() -> void:
	call_deferred("_spawn_new_player")
	pass

func _spawn_new_player()-> void:
	GameManager.spawnPlayer(position + landingPadOffset)
