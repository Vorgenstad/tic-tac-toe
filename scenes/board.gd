extends CanvasLayer

signal cell_pressed(x: int, y: int)

@onready var _grid := _initialize_grid()

func mark_cell(x: int, y: int, value: Constants.CellValue) -> void:
	_grid[x][y].mark(value)

func _initialize_grid() -> Array:
	var grid = [[], [], []]

	for x in 3:
		for y in 3:
			var cell: Cell = $GridContainer.get_node("Cell" + str(x) + str(y))

			cell.initialize(x, y)

			cell.connect("pressed", _on_cell_pressed.bind(x, y))

			grid[x].append(cell)
	
	return grid

func _on_cell_pressed(x: int, y: int) -> void:
	cell_pressed.emit(x, y)
