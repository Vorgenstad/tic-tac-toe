class_name Session

var XScore = 0;
var OScore = 0;

func add_win(winner: Constants.Winner) -> void:
	match winner:
		Constants.Winner.X:
			XScore += 1
		Constants.Winner.O:
			OScore += 1
		_:
			pass