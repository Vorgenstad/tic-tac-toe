class_name Cell

extends Button

var _x: int
var _y: int

func initialize(x: int, y: int) -> void:
    _x = x
    _y = y

func test() -> void:
    print("pressed " + str(_x) + str(_y))