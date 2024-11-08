class_name Cell

extends Button

var _x: int
var _y: int

func initialize(x: int, y: int) -> void:
    _x = x
    _y = y

func mark(value: Constants.CellValue) -> void:
    if value == Constants.CellValue.X:
        text = "X"
    else:
        text = "O"

    disabled = true