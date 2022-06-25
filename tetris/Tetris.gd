extends Node2D

class_name Tetris

signal build(block)
signal change_cord(block, vcord)
signal on_ground(block, vcord)

onready var Block = preload("res://tetris/Block.tscn")

var block_map := [] # Block list
var block_virtual_cord := []

func _ready():
	pass
	

func init():
	print(self, 'init')
	pre_gen()
	gen()
	post_gen()


func rotate_block() -> Array:
	return block_map
	
	
func speedup_downward():
	# change the speed
	pass


func pre_gen():
	pass
	

func gen():
	print(self, 'gen')
	_build()
	

func post_gen():
	pass


func pre_move():
	pass
	

# 所有的移动都需要调用这个函数
func move(dir: Vector2):
	_move_blocks(dir)
	

# 移动之后重新绘制
func post_move():
	pass


# 最开始生成可用
func _build():
	block_map.clear()
	print(self, 'build')
	for cord in block_virtual_cord:
		var _block = Block.instance()
		var _block_holder = BlockMap.get_blockholder(cord)
		_block.block_holder = _block_holder
		_block.set_color(Color.red)
		block_map.append(_block)
		self.emit_signal("build", _block)


func _move_blocks(dir: Vector2) -> bool:
	for block in block_map:
		var vcord: Vector2 = block.block_holder.cord + dir
		var isIdle = BlockMap.is_idle(vcord)
		# if (block.block_holder.cord + dir).y < 0:
		#	return false
		#	emit_signal("on_ground", block, block.block_holder.cord)
		if !isIdle:
			if vcord.y < 0: emit_signal("on_ground", block, block.block_holder.cord)
			return false
	for block in block_map:
		var vcord = block.block_holder.cord + dir
		block.block_holder = BlockMap.get_blockholder(vcord)
		emit_signal("change_cord", block, vcord)
	return true


func debug_vcord():
	var lz := []
	for block in block_map:
		lz.append(block.block_holder.cord)
	print(lz)
