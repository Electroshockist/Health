## A box that gets hit
class_name Hitbox
extends Area3D

@onready var healthbox_manager: HealthboxManager = owner.healthbox_manager

func _ready() -> void:
	add_to_group(healthbox_manager.team)

func on_hit(source:Hurtbox):
	healthbox_manager.health.change_health(source)
