class_name Game
extends Node2D

var _current_value := Constants.CellValue.X
var _plays := 0

@onready var _board: Board = %Board
@onready var _ui: UI = %UI

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
	var winner := _get_winner(points)

	if winner == Constants.Winner.NONE:
		_display_game_over(winner)
		return

	var first_cell_center = _get_cell_center(winning_line[0])
	var last_cell_center = _get_cell_center(winning_line[2])

	var line := _setup_line(first_cell_center)

	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_method(
		func(new_position: Vector2): line.set_point_position(1, new_position),
		first_cell_center,
		last_cell_center,
		0.5)

	tween.finished.connect(_display_game_over.bind(winner))

func _setup_line(start: Vector2) -> Line2D:
	var line = Line2D.new()

	line.default_color = Color(200, 0, 0)
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND

	line.add_point(start, 0)
	line.add_point(start, 1)

	_board.add_child(line)

	return line

func _get_cell_center(cell: Cell) -> Vector2:
	return cell.position + cell.size / 2

func _display_game_over(winner: int) -> void:
	_ui.visible = true
	_ui.display_game_over(winner)

func _get_winner(points: int) -> Constants.Winner:
	match points:
		3: return Constants.Winner.X
		-3: return Constants.Winner.O
		_: return Constants.Winner.NONE

func _on_ui_restart_actioned() -> void:
	get_tree().reload_current_scene()
