class_name CpuPlayer
extends Player

var _ai: AI

func initialize(board: Board) -> void:
	_board = board
	_ai = EasyAI.new(board, _value)

func play() -> void:
	_ai.play()
