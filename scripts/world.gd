extends Node

var num_points: int = 000
var score_prefix: String = "00"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_worker_point_gained() -> void:
	num_points+=1
	if num_points == 10:
		score_prefix = "0"
	if num_points == 100:
		score_prefix = ""
	$Score.set_text(score_prefix + str(num_points))
