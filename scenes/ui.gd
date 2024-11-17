class_name UI
extends CanvasLayer

signal restart_actioned

@onready var _info_label = %InfoLabel

func display_game_over(winner: Constants.Winner) -> void:
	match winner:
		Constants.Winner.X:
			_info_label.text = "X won"
		Constants.Winner.O:
			_info_label.text = "O won"
		Constants.Winner.NONE:
			_info_label.text = "Draw"

func _on_restart_button_pressed() -> void:
	restart_actioned.emit()
