class_name MediumAI
extends AI

func play() -> void:
	if randf() < 0.4:
		_play_random()
	else:
		_play_smart()
