class_name Player
extends Node

var _board: Board

var value: Constants.CellValue

func _init(cell_value: Constants.CellValue) -> void:
	value = cell_value

func initialize(board: Board) -> void:
	_board = board

func play() -> void:
	pass

func _on_board_cell_pressed(x: int, y: int) -> void:
	_board.mark_cell(x, y, value)
