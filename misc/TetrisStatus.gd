extends Node

enum{
	MOVING,
	STUCK,
	STATIC
}

var state := {
	MOVING: TetrisMoving,
	STUCK: TetrisStuck,
	STATIC: TetrisStatic
}
