extends Node

@export var gameScene: PackedScene

func _on_menu_start_actioned(secondPlayerType: Constants.SecondPlayerType) -> void:
	var game: Game = gameScene.instantiate()

	var firstPlayer := HumanPlayer.new(Constants.CellValue.X)

	var secondPlayer := _build_second_player(secondPlayerType)

	game.initialize(firstPlayer, secondPlayer)

	add_child(game)

	$Menu.queue_free()

func _build_second_player(secondPlayerType: Constants.SecondPlayerType) -> Player:
	match secondPlayerType:
		Constants.SecondPlayerType.HUMAN:
			return HumanPlayer.new(Constants.CellValue.O)
		Constants.SecondPlayerType.CPU:
			return CpuPlayer.new(Constants.CellValue.O)
		_:
			assert(false, "Unexpected second player type")
	
	return null
