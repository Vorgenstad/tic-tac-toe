extends CanvasLayer

@onready var _mode_buttons: Control = %ModeButtons
@onready var _difficulty_buttons: Control = %DifficultyButtons

signal start_actioned(secondPlayer: Constants.SecondPlayerType, difficulty: Constants.Difficulty)

func _on_player_button_pressed() -> void:
	start_actioned.emit(Constants.SecondPlayerType.HUMAN)

func _on_cpu_button_pressed() -> void:
	_mode_buttons.visible = false
	_difficulty_buttons.visible = true

func _on_difficulty_button_pressed(difficulty: Constants.Difficulty) -> void:
	start_actioned.emit(Constants.SecondPlayerType.CPU, difficulty)
