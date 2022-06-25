extends Node2D

signal downward()

var speed := 1  # 1 block per second
var timer = null
var tetris: Tetris = null

var tetris_list := [Itetris.new(), Ltetris.new()]

onready var move_horizental_timer := $MoveHorizenTimer
onready var tetris_container := $Tetris
onready var stuck_timer := $StuckTimer

func _ready():
	randomize()
	$Timer.connect("timeout", self, "tetris_downward")
	stuck_timer.connect("timeout", self, "_ground")
	
	# 初始化容器的左下角的位置当成bias
	BlockMap.set_bias($Position2D.position)
	
	# 随机挑选一个
	var t: Tetris = _randomly_tetris()
	tetris = t
	
	BlockMap.debug_set_block(Vector2.ZERO)
	BlockMap.debug_set_block(Vector2(0,1))
	BlockMap.debug_set_block(Vector2(1,0))


func _unhandled_input(event):
	if event.is_action("left"):
		if event.is_pressed() && move_horizental_timer.time_left == 0.0:
			tetris_horizental(Vector2(-1, 0))
			move_horizental_timer.start()
			tetris.state = TetrisStatus.MOVING
	if event.is_action("right"):
		if event.is_pressed() && move_horizental_timer.time_left == 0.0:
			tetris_horizental(Vector2(1, 0))
			move_horizental_timer.start()
			tetris.state = TetrisStatus.MOVING


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
	# tetris.debug_vcord()
	self.emit_signal("downward")


func tetris_horizental(dir):
	if tetris == null: return
	tetris.pre_move()
	tetris.move(dir)
	tetris.post_move()
	# tetris.debug_vcord()


func _change_cord(_block, _vcord):
	_block.position = BlockMap.virtual2pos(_vcord)


func _stuck(_block, _vcord):
	print(_block, '_stuck')
	tetris.state = TetrisStatus.STUCK
	if stuck_timer.time_left == 0: stuck_timer.start()


# stuck 状态保持 1s
func _ground():
	print(tetris, 'ground!')
	yield(self, 'downward')
	stuck_timer.stop()
	$Timer.stop()
	tetris.state = TetrisStatus.STATIC
	# todo 这里还应处理一下网格的状态
	tetris.ground()
	tetris = null
	
	# 随机挑选一个
	var t: Tetris = _randomly_tetris()
	tetris = t
	$Timer.start()


func _randomly_tetris():
	var size := len(tetris_list)
	var idx := randi() % size
	var t: Tetris = tetris_list[idx]
	tetris_container.add_child(t)	
	t.connect("build", self, "_build")
	t.connect("change_cord", self, "_change_cord")
	t.connect("stuck", self, "_stuck")
	t.init()
	return t
