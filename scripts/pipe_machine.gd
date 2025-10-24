extends Node

@onready var Pipe: PackedScene = load("res://scenes/pipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(get_tree().get_node_count_in_group("Pipes"))


func _on_timer_timeout() -> void:
	var pipe: Node = Pipe.instantiate()
	var timer: Timer = $PipeGapTimer
	var decrementer: float = 0.01
	var timer_bottom: float = 1.1
	pipe.set_position(Vector2(512+30,randi_range(175,594)))
	add_child(pipe)
	if timer.get_wait_time() > timer_bottom:
		timer.set_wait_time(timer.get_wait_time()-decrementer)
	#print(timer.get_wait_time())
	
	
	#print("juice")
	#print(get_viewport().size)
