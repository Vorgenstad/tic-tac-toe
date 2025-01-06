class_name CpuPlayer
extends Player

func play() -> void:
	var random_cell := Vector2(randi_range(0, 2), randi_range(0, 2))

	_board.mark_cell(int(random_cell.x), int(random_cell.y), value)
