class_name HardAI
extends AI

func play() -> void:
	for line in _board.lines:
		var score = _get_score(line)

		if score == 2 || score == -2:
			_mark_line(line)
			return
	
	for corner_cell in [_board.grid[0][0], _board.grid[0][2], _board.grid[2][0], _board.grid[2][2]]:
		if corner_cell.value == Constants.CellValue.EMPTY:
			corner_cell.mark(_value)
			return

func _get_score(line: Array):
	return _get_cell_value_points(line[0].value) + _get_cell_value_points(line[1].value) + _get_cell_value_points(line[2].value)

func _get_cell_value_points(value: Constants.CellValue) -> int:
	match value:
		Constants.CellValue.X:
			return 1
		Constants.CellValue.O:
			return -1
		_:
			return 0

func _mark_line(line: Array) -> void:
	for cell in line:
		if cell.value == Constants.CellValue.EMPTY:
			cell.mark(_value)
			return