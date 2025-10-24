extends Node

var num_points: int = 000
var score_prefix: String = "00"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Restart"):
		queue_free()
		get_tree().reload_current_scene()

func _on_worker_point_gained() -> void:
	var tween: Tween = create_tween()
	var font_juice: float = 0.5
	num_points+=1
	if num_points == 10:
		score_prefix = "0"
	if num_points == 100:
		score_prefix = ""
	$Score.set_text(score_prefix + str(num_points))
	tween.tween_property($Score, "label_settings:font_size", 69+(font_juice*num_points), 0.1)
	tween.tween_property($Score, "label_settings:font_size", 64, 0.5)
	print(69+(font_juice*num_points))
	
	


func _on_button_pressed() -> void:
	queue_free()
	get_tree().reload_current_scene()
