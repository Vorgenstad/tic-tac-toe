class_name HumanPlayer
extends Player

func initialize(board: Board) -> void:
	_board = board

func play() -> void:
	_board.cell_pressed.connect(_on_board_cell_pressed)

func _on_board_cell_pressed(x: int, y: int) -> void:
	_board.cell_pressed.disconnect(_on_board_cell_pressed)

	_board.mark_cell(x, y, value)
