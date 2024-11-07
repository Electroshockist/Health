class_name Health
extends Node

signal depleated
signal filled

signal damaged
signal healed
signal value_changed

signal recharging_begun
signal recharging_interrupted

var _invulderable := false
var _can_heal := true

## The rate at which the healthbar recharges.
## Set to 0 if unwanted.
@export var recharge_rate := 0.0
## The delay that before recharging after taking damage.
## Has no effect if recharge_rate is set to 0.
@export var recharge_delay := 0.0

var _max_health := 100.0

@export var max_health :float:
	get:
		return _max_health
	set(value):
		_max_health = value
		#if healthbar can't be overhealed, set current health to new value
		if current_health > value and not _can_overheal:
			current_health = max_health

var _current_health:= _max_health
## Set to max health by default
@export var current_health :float:
	get:
		return _current_health
	
	set(value):		
		if (value < 0 and not _can_underheal):
			_current_health = 0
			depleated.emit()
		elif (value > max_health and not _can_overheal):
			_current_health = max_health
		else:
			_current_health = value

## Can the healthbar be depleated past 0
@export var _can_underheal := false
## Can the healthbar be filled past max_health
@export var _can_overheal := false


# Time until the bar can recarge
var _recharge_cooldown := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if recharge_rate > 0:
		_handle_recharge(delta)
	pass

func _handle_recharge(delta):
	#wait to recharge
	if _recharge_cooldown > 0:
		_recharge_cooldown -= delta
		return
	if _current_health < _max_health:
		_current_health += recharge_rate

# Call to change value
# Negative numbers add to health
func reduce_value(value):
	if value > 0:
		_damage(value)
	else:
		_heal(value)
		

func _damage(value):
	#reset recharge on damage
	_recharge_cooldown = recharge_delay
func _heal(value):
	if _can_heal and _current_health <= 0:
		_current_health
