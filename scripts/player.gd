class_name Player
extends Node

var _board: Board

var _value: Constants.CellValue

func _init(value: Constants.CellValue) -> void:
	_value = value

func initialize(board: Board) -> void:
	_board = board

func play() -> void:
	pass
