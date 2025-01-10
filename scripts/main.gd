extends Node

@export var menu_scene: PackedScene
@export var game_scene: PackedScene

func _setup_game(secondPlayerType: Constants.SecondPlayerType, difficulty: Constants.Difficulty) -> Game:
	var game: Game = game_scene.instantiate()

	game.exit_actioned.connect(_on_game_exit_actioned)

	var firstPlayer := HumanPlayer.new(Constants.CellValue.X)

	var secondPlayer := _build_second_player(secondPlayerType, difficulty)

	game.initialize(firstPlayer, secondPlayer)

	return game

func _build_second_player(secondPlayerType: Constants.SecondPlayerType, difficulty: Constants.Difficulty) -> Player:
	match secondPlayerType:
		Constants.SecondPlayerType.HUMAN:
			return HumanPlayer.new(Constants.CellValue.O)
		Constants.SecondPlayerType.CPU:
			return CpuPlayer.new(Constants.CellValue.O, difficulty)
		_:
			assert(false, "Unexpected second player type")
	
	return null

func _on_menu_start_actioned(secondPlayerType: Constants.SecondPlayerType, difficulty: Constants.Difficulty) -> void:
	var game := _setup_game(secondPlayerType, difficulty)

	add_child(game)

	$Menu.queue_free()

func _on_game_exit_actioned() -> void:
	var menu := menu_scene.instantiate()

	menu.start_actioned.connect(_on_menu_start_actioned)

	add_child(menu)

	$Game.queue_free()
