class_name CpuPlayer
extends Player

func play() -> void:
	var random_cell := _board.available_cells[randi() % _board.available_cells.size()]

	random_cell.mark(value)
