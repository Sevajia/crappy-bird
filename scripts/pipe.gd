extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$PipeSprites.set_frame(randi()%2) # This number can be changed
	$PipeSprites.set_flip_v(bool(randi()%2))
	add_to_group("Pipes")
	
	#print(global_position.y)
	
	#print($PipeSprites.get_frame())
	#
	#var zeroes = 0
	#var ones = 0
	#for i in range(0,10000000):
		#$PipeSprites.set_frame(randi()%2)
		#if $PipeSprites.get_frame() == 0:
			#zeroes += 1
		#if $PipeSprites.get_frame() == 1:
			#ones += 1
		#
	#print("zeroes = " + str(zeroes))
	#print("ones = " + str(ones))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_global_position(global_position+Vector2(-4,0))


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
