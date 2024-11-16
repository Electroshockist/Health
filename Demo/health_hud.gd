extends Control

@export var _health: Health

@export var heal_amount := 2.3
@export var damage_amount := 3.1


func _input(event: InputEvent) -> void:
	if event.is_action_released("Heal"):
		_health.heal(heal_amount)
	elif event.is_action_released("Damage"):
		_health.damage(damage_amount)
		
