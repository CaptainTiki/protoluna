class_name UnitLight extends PointLight2D

@onready var time_manager: TimeManager = $"../../../Managers/Time_Manager"

func _ready() -> void:
	color = Color(0.8,0.8,1,1)
	if time_manager.is_daytime: 
		energy = 0
	else: 
		energy = 1
	
	time_manager.day_started.connect(_on_day_started)
	time_manager.night_started.connect(_on_night_started)
	pass

func _on_day_started() -> void:
	tween_light(0.0)
	pass
	
func _on_night_started() -> void:
	tween_light(1.0)
	pass

func tween_light(target_energy: float):
	print("Changing to energy: ", target_energy)
	var tween = create_tween()
	tween.tween_property(self, "energy", target_energy, 2.0)  # Smoothly transition energy over 2 seconds
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	pass
