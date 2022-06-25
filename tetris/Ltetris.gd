extends Tetris

class_name Itetris

func _ready():
	block_virtual_cord = [Vector2(0,12),Vector2(0,13),Vector2(0,14), Vector2(0,15)]
	

func init():
	.init()


func rotate_block() -> Array:
	return block_map
	
	
func speedup_downward():
	# change the speed
	pass
