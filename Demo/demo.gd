extends Node3D
@onready var animation_player: AnimationPlayer = $Entity/AnimationPlayer

func _on_button_button_down() -> void:
	animation_player.play("Swing")
