extends Building

@onready var rootNode = $"../../Units"

@export var drone_spawn : PackedScene = preload("res://Units/GunDrone/gun_drone.tscn")

var landingPadOffset : Vector2 = Vector2(192,-16)

func _init() -> void:
	display_text = "[center]Armory[/center]"
	label_offset = Vector2(-120,-240)
	bar_label = str(action_cost)
	bar_size = Vector2(100,10)
	bar_offset = Vector2(-50,-220)

func _ready() -> void:
	print(action_cost)
	pass

func on_resource_filled() -> void:
	super.on_resource_filled()
	#spawn a new worker drone
	var new_drone : GunDrone = drone_spawn.instantiate()
	new_drone.name = "Gun_Drone"
	new_drone.global_position = position + landingPadOffset
	rootNode.add_child(new_drone)
	pass
