class_name UI
extends CanvasLayer

signal restart_actioned

@onready var _info_label = %InfoLabel
@onready var _x_score_label = %XScoreLabel
@onready var _o_score_label = %OScoreLabel

func display_game_over(winner: Constants.Winner, session: Session) -> void:
	match winner:
		Constants.Winner.X:
			_info_label.text = "X wins"
		Constants.Winner.O:
			_info_label.text = "O wins"
		Constants.Winner.NONE:
			_info_label.text = "Draw"

	_x_score_label.text = str(session.XScore)
	_o_score_label.text = str(session.OScore)
	

func _on_restart_button_pressed() -> void:
	restart_actioned.emit()
