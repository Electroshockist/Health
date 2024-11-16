extends ProgressBar
@onready var _health: Health = $"../Health"

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = _health.max_health
	value = _health.current_health
	
	updateUI(_health.current_health)


func _on_health_value_changed(current_value: float, _change:float) -> void:
	updateUI(current_value)

func updateUI(current_value: float):
	value = current_value
	label.text = "%10.2f"%current_value
