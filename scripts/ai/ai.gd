class_name AI

var _board: Board
var _value: Constants.CellValue
var _corner_cells: Array[Cell]
var _side_cells: Array[Cell]

func _init(board: Board, value: Constants.CellValue) -> void:
	_board = board
	_value = value

	_corner_cells = [_board.grid[0][0], _board.grid[0][2], _board.grid[2][0], _board.grid[2][2]]
	_side_cells = [_board.grid[0][1], _board.grid[1][0], _board.grid[1][2], _board.grid[2][1]]

func play() -> void:
	pass

func _play_random() -> void:
	var random_cell := _board.available_cells[randi() % _board.available_cells.size()]

	random_cell.mark(_value)

func _play_smart() -> void:
	for line in _board.lines:
		var score = _get_score(line)

		if score == 2 || score == -2:
			_mark_line(line)
			return
		
	var center_value = _board.grid[1][1].value

	match center_value:
		Constants.CellValue.EMPTY:
			_board.grid[1][1].mark(_value)
		_value:
			_play_random_side()
		_:
			_play_random_corner()

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

func _play_random_side() -> void:
	_side_cells.shuffle()

	for side_cell in _side_cells:
		if side_cell.value == Constants.CellValue.EMPTY:
			side_cell.mark(_value)
			return

func _play_random_corner() -> void:
	_corner_cells.shuffle()

	for corner_cell in _corner_cells:
		if corner_cell.value == Constants.CellValue.EMPTY:
			corner_cell.mark(_value)
			return
