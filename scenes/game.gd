extends Node2D

var _current_value = Constants.CellValue.X

func _on_board_cell_pressed(x: int, y: int) -> void:
	%Board.mark_cell(x, y, _current_value)

	_current_value = Constants.CellValue.O if _current_value == Constants.CellValue.X else Constants.CellValue.X
