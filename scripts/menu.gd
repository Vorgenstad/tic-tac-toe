extends CanvasLayer

signal start_actioned(secondPlayer: Constants.SecondPlayerType)

func _on_player_button_pressed() -> void:
	start_actioned.emit(Constants.SecondPlayerType.HUMAN)

func _on_cpu_button_pressed() -> void:
	start_actioned.emit(Constants.SecondPlayerType.CPU)
