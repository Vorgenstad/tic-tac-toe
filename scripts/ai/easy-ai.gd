class_name EasyAI
extends AI

func play() -> void:
	var random_cell := _board.available_cells[randi() % _board.available_cells.size()]

	random_cell.mark(_value)
