class_name Game
extends Node2D

signal exit_actioned

var _plays := 0

var _x_player: Player
var _o_player: Player

var _current_player : Player

@onready var _board: Board
@onready var _ui: UI

@onready var _session := Session.new()

func initialize(x_player: Player, o_player: Player) -> void:
	_x_player = x_player
	_o_player = o_player
	
func _ready() -> void:
	_board = %Board
	_ui = %UI

	_x_player.initialize(_board)
	_o_player.initialize(_board)

	_current_player = _x_player

	_current_player.play()

func reset() -> void:
	_current_player = _x_player
	_plays = 0

	_board.reset()

	_current_player.play()

func _check_win() -> bool:
	for line in _board.lines:
		var points := _get_points(line[0].value, line[1].value, line[2].value)

		if _check_winning_points(points):
			_game_over(points, line)
			return true
	
	return false

func _get_points(value1: Constants.CellValue, value2: Constants.CellValue, value3: Constants.CellValue) -> int:
	return _get_cell_value_points(value1) + _get_cell_value_points(value2) + _get_cell_value_points(value3)

func _get_cell_value_points(value: Constants.CellValue) -> int:
	match value:
		Constants.CellValue.X:
			return 1
		Constants.CellValue.O:
			return -1
		_:
			return 0

func _check_winning_points(points: int) -> bool:
	return points == 3 || points == -3

func _game_over(points: int, winning_line: Array) -> void:
	_board.disable()

	var winner := _get_winner(points)

	_session.add_win(winner)

	if winner == Constants.Winner.NONE:
		_display_game_over(winner)
		return

	var tween = _board.draw_winning_line(winning_line)

	tween.finished.connect(_display_game_over.bind(winner))

func _display_game_over(winner: Constants.Winner) -> void:
	_ui.visible = true
	_ui.display_game_over(winner, _session)

func _get_winner(points: int) -> Constants.Winner:
	match points:
		3: return Constants.Winner.X
		-3: return Constants.Winner.O
		_: return Constants.Winner.NONE

func _on_board_cell_marked() -> void:
	_plays = _plays + 1

	var is_win := _check_win()

	if (!is_win):
		if (_plays == 9):
			_game_over(0, [])
		else:
			_next_turn()

func _next_turn() -> void:
	_current_player = _x_player if _current_player == _o_player else _o_player

	_current_player.play()

func _on_ui_restart_actioned() -> void:
	_ui.visible = false
	reset()	

func _on_ui_exit_actioned() -> void:
	exit_actioned.emit()
