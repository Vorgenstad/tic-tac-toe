class_name Game
extends Node2D

var _current_value := Constants.CellValue.X
var _plays := 0

@onready var _board: Board = %Board
@onready var _ui: UI = %UI

func reset() -> void:
	_current_value = Constants.CellValue.X
	_plays = 0
	
	_board.reset()

func _on_board_cell_pressed(x: int, y: int) -> void:
	_board.mark_cell(x, y, _current_value)

	_plays = _plays + 1

	var is_win := _check_win()

	if (!is_win && _plays == 9):
		_game_over(0, [])

	_current_value = Constants.CellValue.O if _current_value == Constants.CellValue.X else Constants.CellValue.X

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

	if winner == Constants.Winner.NONE:
		_display_game_over(winner)
		return

	var tween = _board.draw_winning_line(winning_line)

	tween.finished.connect(_display_game_over.bind(winner))

func _display_game_over(winner: Constants.Winner) -> void:
	_ui.visible = true
	_ui.display_game_over(winner)

func _get_winner(points: int) -> Constants.Winner:
	match points:
		3: return Constants.Winner.X
		-3: return Constants.Winner.O
		_: return Constants.Winner.NONE

func _on_ui_restart_actioned() -> void:
	_ui.visible = false
	reset()	
