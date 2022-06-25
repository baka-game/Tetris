extends Node

class_name TetrisMoving

static func to(state: int):
	match state:
		TetrisStatus.STUCK:
			pass
		_:
			pass
