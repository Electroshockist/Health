extends Label

@onready var _health: Health = owner.health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_health.value_changed.connect(_on_health_value_changed)
	updateUI(_health.current_health)

func _on_health_value_changed(current_value: float) -> void:
	updateUI(current_value)

func updateUI(current_value: float):
	text = "%10.2f"%current_value
