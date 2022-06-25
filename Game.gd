extends Node2D

signal downward()

var speed := 1  # 1 block per second
var timer = null
var tetris: Tetris = null

var tetris_list := []

func _ready():
	$Timer.connect("timeout", self, "tetris_downward")
	
	# 初始化容器的底部
	BlockMap.set_bias($Position2D.position)
	var t: Tetris = Itetris.new()
	$Tetris.add_child(t)
	t.connect("build", self, "_build")
	t.connect("change_cord", self, "_change_cord")
	t.connect("on_ground", self, "_on_ground")
	t.init()
	tetris = t


func _build(_block): # Block
	print('_build')
	var _pos = BlockMap.virtual2pos(_block.block_holder.cord)
	$Container.add_child(_block)
	_block.position = _pos


func tetris_downward():
	if tetris == null: return
	tetris.pre_move()
	tetris.move(Vector2(0, -1))
	tetris.post_move()
	tetris.debug_vcord()
	self.emit_signal("downward")
	

func _change_cord(_block, _vcord):
	_block.position = BlockMap.virtual2pos(_vcord)


func _on_ground(_block, _vcord):
	yield(self, "downward")
	print('on ground!')
	tetris = null
