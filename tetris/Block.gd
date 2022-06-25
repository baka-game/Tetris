extends Node2D

onready var sprite := $Sprite

var color: Color setget set_color
var state: int = BlockType.state.MOVING
var block_holder: BlockHolder = null

func _ready():
	sprite.set_modulate(color)


func set_color(_color: Color):
	color = _color
	if sprite != null:
		sprite.set_modulate(color)


func ground():
	state = BlockType.state.STATIC
	block_holder.is_idle = false
	print(BlockMap.is_idle(block_holder.cord))
	sprite.set_modulate(Color.violet)



