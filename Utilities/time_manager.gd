class_name TimeManager extends Node

# Time durations (in seconds)
@export var day_duration: float = 180.0
@export var night_duration: float = 180.0
@export var day_color: Color = Color(1,1,1,1) # Bright and white for daytime
@export var night_color: Color = Color(0.5,0.5,0.7,1) #dim and blueish for nighttime


@onready var timer: Timer = $Timer
@onready var canvas_modulate: CanvasModulate = $"../../CanvasModulate"

# Signals for day/night transitions
signal day_started
signal night_started

# internal state variables
var is_daytime: bool = true

func _ready():
	start_day() #always start at day time?

func _process(_delta: float) -> void:
	#increment time
	if timer:
		GameManager.update_debug_time(is_daytime, str(int(timer.time_left))) 
	pass

func start_day() -> void:
	is_daytime = true
	emit_signal("day_started")
	timer.start(day_duration)
	transition_to_color(day_color)
	pass

func start_night() -> void:
	is_daytime = false
	emit_signal("night_started")
	timer.start(night_duration)
	transition_to_color(night_color)
	pass

func _on_timer_timeout() -> void:
	if is_daytime:
		start_night()
	else:
		start_day()
	pass

func transition_to_color(target_color: Color) -> void:
	var tween = create_tween()
	tween.tween_property(canvas_modulate, "color", target_color, 2.0)
	tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	pass
