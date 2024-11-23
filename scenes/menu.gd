extends CanvasLayer

signal start_actioned()

func _on_play_button_pressed() -> void:
    start_actioned.emit()