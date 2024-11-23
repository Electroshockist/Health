## A box that hits
class_name Hurtbox
extends Area3D

@onready var healthbox_manager:HealthboxManager = owner

@export var val := -1.0:
	get: return val

func _ready() -> void:
	add_to_group(healthbox_manager.team)
	area_entered.connect(_on_area_entered)
	monitorable = false

func _on_area_entered(node:Node3D):
	if node is Hitbox and not node.is_in_group(healthbox_manager.team):
		node.on_hit(self)
