class_name Board
extends CanvasLayer

signal cell_pressed(x: int, y: int)
signal cell_marked()

var lines: Array

var _grid: Array
var _line: Line2D

func _ready() -> void:
	_grid = [[], [], []]

	for x in 3:
		for y in 3:
			var cell: Cell = $GridContainer.get_node("Cell" + str(x) + str(y))

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

	_line = Line2D.new()

	_line.default_color = Color(200, 0, 0)
	_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	_line.end_cap_mode = Line2D.LINE_CAP_ROUND

	add_child(_line)

func reset() -> void:
	for row in _grid:
		for cell in row:
			cell.reset()

	_line.clear_points()

func mark_cell(x: int, y: int, value: Constants.CellValue) -> void:
	_grid[x][y].mark(value)

	cell_marked.emit()

func disable() -> void:
	for row in _grid:
		for cell in row:
			if !cell.marked:
				cell.disabled = true

func draw_winning_line(winning_line: Array) -> Tween:
	var first_cell_center = _get_cell_center(winning_line[0])
	var last_cell_center = _get_cell_center(winning_line[2])

	_line.clear_points()

	_line.add_point(first_cell_center, 0)
	_line.add_point(first_cell_center, 1)

	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_method(
		func(new_position: Vector2): _line.set_point_position(1, new_position),
		first_cell_center,
		last_cell_center,
		0.5)

	return tween

func _get_cell_center(cell: Cell) -> Vector2:
	return cell.position + cell.size / 2

func _on_cell_pressed(x: int, y: int) -> void:
	cell_pressed.emit(x, y)
