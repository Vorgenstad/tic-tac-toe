class_name Board
extends CanvasLayer

signal cell_pressed(x: int, y: int)

var lines: Array

var _grid: Array

func _ready() -> void:
	_grid = [[], [], []]

	for x in 3:
		for y in 3:
			var cell: Cell = $GridContainer.get_node("Cell" + str(x) + str(y))

			cell.initialize(x, y)

			cell.connect("pressed", _on_cell_pressed.bind(x, y))

			_grid[x].append(cell)
	
	lines = [
		[_grid[0][0], _grid[0][1], _grid[0][2]],
		[_grid[1][0], _grid[1][1], _grid[1][2]],
		[_grid[2][0], _grid[2][1], _grid[2][2]],
		[_grid[0][0], _grid[1][0], _grid[2][0]],
		[_grid[0][1], _grid[1][1], _grid[2][1]],
		[_grid[0][2], _grid[1][2], _grid[2][2]],
		[_grid[0][0], _grid[1][1], _grid[2][2]],
		[_grid[0][2], _grid[1][1], _grid[2][0]],
	]

func mark_cell(x: int, y: int, value: Constants.CellValue) -> void:
	_grid[x][y].mark(value)

func _on_cell_pressed(x: int, y: int) -> void:
	cell_pressed.emit(x, y)
