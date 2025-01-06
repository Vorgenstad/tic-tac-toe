class_name Cell

extends Button

var value := Constants.CellValue.EMPTY
var marked := value != Constants.CellValue.EMPTY

func reset() -> void:
	text = ""
	disabled = false
	value = Constants.CellValue.EMPTY

func mark(value_to_mark: Constants.CellValue) -> void:
	value = value_to_mark

	if value_to_mark == Constants.CellValue.X:
		text = "X"
	else:
		text = "O"

	disabled = true
