@tool
class_name Health
extends Node

signal depleated
signal filled

## Passes current health and change as args
signal value_changed

@export var damageable := true
@export var healable := true

@export var max_health := 100.0:
	get:
		return max_health
	set(value):
		max_health = value
		#if healthbar can't be overhealed, set current health to new value
		if current_health > value:
			current_health = max_health

## Set to max health by default
var current_health := max_health:
	get:
		return current_health
	
	set(value):
		#var change = value-current_health
		if value != current_health:
			current_health = value
			# Depletion
			if current_health <= 0:
				current_health = 0
				depleated.emit()
			#filled
			elif current_health >= max_health:
				current_health = max_health
				filled.emit()
				
			value_changed.emit(current_health)

func change_health(source: Hurtbox):
	#checks if value is damage or healing and possible
	if source.val < 0 and damageable or source.val >= 0 and healable:
		current_health += source.val
