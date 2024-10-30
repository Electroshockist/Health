extends Control

signal depleated
signal damaged
signal filled
signal recharging_begun

## The rate at which thehealthbar recharges.
## Set to 0 if unwanted
@export var recharge_rate := 0.0
## The delay that before recharging after taking damage
@export var recharge_delay := 0.0

@export var max_health := 100.0

@export var _current_health := max_health

##time until the bar can recarge
var _time_to_recharge := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if recharge_rate > 0:
		_handle_recharge(delta)
	pass

func _handle_recharge(delta):
	#wait to recharge
	if _time_to_recharge > 0:
		_time_to_recharge -= delta
		return
	if _current_health < max_health:
		_current_health += recharge_rate
	
func damage(damage):
	#reset recharge on damage
	_time_to_recharge = recharge_delay
