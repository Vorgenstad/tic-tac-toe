class_name Cell

extends Button

var value := Constants.CellValue.EMPTY

var _x: int
var _y: int

func initialize(x: int, y: int) -> void:
	_x = x
	_y = y

func mark(value_to_mark: Constants.CellValue) -> void:
	value = value_to_mark

	if value_to_mark == Constants.CellValue.X:
		text = "X"
	else:
		text = "O"

	disabled = true