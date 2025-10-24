extends Area2D

signal point_gained

@onready var DEAD: bool = false
@onready var ANIMATION: String = "default"
@onready var velocity: Vector2 = Vector2(0,0.01)
@onready var velocity_delta: Vector2 = Vector2(0,0.04)
@onready var delta_bound: float = 0.08


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_node("FaceSprites").play()
	$FaceSprites.play(ANIMATION) 
	$NearMissSprites.set_frame(1)
	$NearMissSprites.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Old Test Movment
	#if Input.is_physical_key_pressed(KEY_RIGHT):
		#set_global_position(Vector2(global_position.x+1,global_position.y))
	#if Input.is_physical_key_pressed(KEY_LEFT):
		#set_global_position(Vector2(global_position.x-1,global_position.y))
	#if Input.is_physical_key_pressed(KEY_UP):
		#set_global_position(Vector2(global_position.x,global_position.y-1))
	#if Input.is_physical_key_pressed(KEY_DOWN):
		#set_global_position(Vector2(global_position.x,global_position.y+1))
		
	#if global_position.y > 0 and global_position.y < 768:
		#velocity += velocity_delta
	#else: 
		#velocity = Vector2(0,0)



	# Input Handling
	if Input.is_action_just_pressed("Jump") and global_position.y > 0:
		velocity.y = 0
		velocity_delta.y = -1
		#get_node("FaceSprites").stop()
		#get_node("FaceSprites").play()
		$FaceSprites.stop()
		$FaceSprites.play(ANIMATION)
	
	# Keeps Velocity in bounds
	if velocity_delta.y < delta_bound:
		velocity_delta.y += delta_bound*1.5
	if velocity_delta.y > delta_bound:
		velocity_delta.y = delta_bound
	if velocity.y < - 6:
		velocity.y = - 6
	 
	# Apply Velocity, Set Angle, and Update Velocity
	set_global_position(global_position+velocity)
	if not DEAD:
		set_global_rotation_degrees(velocity.y*2)
		velocity += velocity_delta*4
	
	# Death
	if global_position.y >= 768 and not DEAD:
		velocity = Vector2(0,0)
		set_global_rotation_degrees(30)
	
	# Debug Logs
	#print(velocity.y, " | ", velocity_delta.y)
	#print(global_position.y)
	#print(get_global_rotation_degrees())
	#print($WorkerParticle.texture.noise.get_seed())


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pipes"):
		DEAD = true
		ANIMATION = "death"
		var current_frame = $FaceSprites.get_frame()
		var current_progress = $FaceSprites.get_frame_progress()
		$FaceSprites.play(ANIMATION)
		$FaceSprites.set_frame_and_progress(current_frame, current_progress)
		$NearMissSprites.stop()
		$NearMissSprites.set_frame(1)
		$DeathTrack.play()
		velocity = Vector2(-4,0)
 

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Points") and not DEAD:
		$Point.play()
		$Point.set_pitch_scale($Point.pitch_scale + 0.01)
		point_gained.emit()
		


func _on_near_miss_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pipes"):
		$NearMissSprites.set_frame(0)
		$NearMissSprites.play()
