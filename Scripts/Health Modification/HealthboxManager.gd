## Manages common data between multiple healthboxes
class_name HealthboxManager
extends Node

@export var health: Health:
	get: 
		return health

@export var team: String:
	get:
		return team
