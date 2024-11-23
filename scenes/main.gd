extends Node

@export var gameScene: PackedScene

func _on_menu_start_actioned() -> void:
	var game: Game = gameScene.instantiate()

	add_child(game)

	$Menu.queue_free()
