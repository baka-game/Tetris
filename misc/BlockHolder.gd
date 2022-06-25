extends Node

class_name BlockHolder

var is_idle := true
var type: int = BlockType.normal
var block = null setget set_block, get_block # 对 holder 持有方块的引用
var cord: Vector2


func _ready():
	pass # Replace with function body.


# init all of the props
func init(_is_idle: bool = true, _type: int = BlockType.normal):
	is_idle = _is_idle
	type = _type


func set_block(_block):
	block = _block
	
	
func get_block():
	return block
