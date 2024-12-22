class_name BuildingSlotNode extends Building

@export var deployScene : PackedScene

@onready var rootNode = $"../../Buildings"

func _ready() -> void:
	bar_label = str(action_cost)
	pass

func on_resource_filled() -> void:
	#spawn a new worker drone
	var newBuilding = deployScene.instantiate()
	newBuilding.name = deployScene.resource_path.get_basename()
	newBuilding.global_position = position
	rootNode.add_child(newBuilding)
	
	queue_free()
	pass
