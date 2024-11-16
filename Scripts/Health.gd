class_name Health
extends Node

signal depleated
signal filled

signal value_changed

@export var damageable := true
@export var healable := true

var _max_health := 100.0

@export var max_health :float:
	get:
		return _max_health
	set(value):
		_max_health = value
		#if healthbar can't be overhealed, set current health to new value
		if current_health > value:
			current_health = max_health

var _current_health:= _max_health

## Set to max health by default
@export var current_health :float:
	get:
		return _current_health
	
	set(value):
		# Depletion
		if _current_health <= 0:
			_current_health = 0
			depleated.emit()
		#filled
		elif _current_health >= max_health:
			_current_health = max_health
		
		
		if value != _current_health:
			value_changed.emit()

func heal(value: float):
	if healable:
		_current_health += value

func damage(value: float):
	if damageable:
		_current_health -= value
