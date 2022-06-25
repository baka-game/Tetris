extends Node2D

onready var sprite := $Sprite

var color: Color setget set_color
var state: int = BlockType.state.MOVING
var block_holder: BlockHolder = null

func _ready():
	set_color(color)


func set_color(_color: Color):
	color = _color





