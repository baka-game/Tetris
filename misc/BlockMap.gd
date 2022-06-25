extends Node

# 20 x 10 blocks
var map := []

# 虚拟坐标
# x 坐标向右，y坐标向上
var row := 24 # 实际上是 20 行
var margin_up := 4 # 4 行的冗余供新出现的方块使用
var col := 10
var block_size := 16

var bias := Vector2.ZERO setget set_bias

func _ready():
	init()
	

# init the map 
func init():
	for x in range(col):
		var col := []
		for y in range(row):
			var block = BlockHolder.new()
			block.init(true, BlockType.normal)
			block.cord = Vector2(x, y)
			col.append(block)
		map.append(col)


func set_block_idle(x: int, y: int, _is_idle: bool):
	map[x][y].is_idle = _is_idle
	debug_map()


func get_blockholder(cord: Vector2):
	# 不应该有小于0的数被送进来
	assert(cord.x >= 0 && cord.y >= 0)
	return map[cord.x][cord.y]


func debug_map():
	for y in range(row - 1, -1, -1):
		var row := ''
		for x in range(col):
			var idle: bool = map[y][x].is_idle
			row += String(idle) + ' '
		print(row)


func virtual2pos(cord: Vector2, _bias: Vector2 = bias) -> Vector2:
	return _bias + Vector2(block_size, -block_size) * cord


func set_bias(_bias: Vector2):
	bias = _bias


func is_idle(cord: Vector2):
	if cord.y < 0 || cord.y >= row || cord.x < 0 || cord.x >= col:
		return false
	var _block: BlockHolder = get_blockholder(cord)
	if !_block.is_idle \
		&& (_block.get_block() != null \
		&& _block.get_block().state == BlockType.state.STATIC):
		return false
	return true


onready var Block = preload("res://tetris/Block.tscn")

func debug_set_block(vcord: Vector2):
	var _block = Block.instance()
	var _block_holder = BlockMap.get_blockholder(vcord)
	_block.block_holder = _block_holder
	_block_holder.set_block(_block)
	_block.set_color(Color.wheat)
	_block.state = BlockType.state.STATIC
	get_tree().call_group('game', '_build', _block)
