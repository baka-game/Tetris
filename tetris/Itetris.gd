extends Tetris

class_name Ltetris

func _ready():
	block_virtual_cord = [Vector2(1,12),Vector2(1,13),Vector2(1,14), Vector2(0,14)]
	

func init():
	.init()


func rotate_block() -> Array:
	return block_map
	
	
func speedup_downward():
	# change the speed
	pass
