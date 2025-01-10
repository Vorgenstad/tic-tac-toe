class_name CpuPlayer
extends Player

var _ai: AI
var _difficulty: Constants.Difficulty

func _init(value: Constants.CellValue, difficulty: Constants.Difficulty) -> void:
	_value = value
	_difficulty = difficulty

func initialize(board: Board) -> void:
	_board = board

	match _difficulty:
		Constants.Difficulty.EASY:
			_ai = EasyAI.new(_board, _value)
		Constants.Difficulty.MEDIUM:
			_ai = MediumAI.new(_board, _value)
		Constants.Difficulty.IMPOSSIBLE:
			_ai = UnbeatableAI.new(_board, _value)

func play() -> void:
	_ai.play()
