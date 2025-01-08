class_name EasyAI
extends AI

var _board: Board
var _value: Constants.CellValue

func _init(board: Board, value: Constants.CellValue) -> void:
	_board = board
	_value = value

func play() -> void:
	var random_cell := _board.available_cells[randi() % _board.available_cells.size()]

	random_cell.mark(_value)
