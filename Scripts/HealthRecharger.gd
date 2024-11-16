extends Node
#-- Signals --#
signal recharging_begun
signal recharging_interrupted

# TODO: Create recharge health threshold
# NOTE: Reduce health recharged if the current recharge would go over the threshold
#-- Exports --#
## The health bar that the recharger operates on
@export var health: Health

## The rate at which the healthbar recharges.
## Set to 0 if unwanted.
@export var recharge_rate := 0.0

## The delay that before recharging after taking damage.
## Has no effect if recharge_rate is set to 0.
@export var recharge_delay := 0.0

#-- Private Variables --#
# Time until the bar can recarge
var _recharge_cooldown := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#wait to recharge
	if _recharge_cooldown > 0:
		_recharge_cooldown -= delta
	elif health.current_health < health.max_health:
		health.current_health += recharge_rate * delta
