extends Node

@export var audio: AudioStream = null

@export var bubble_scale : Vector2 = Vector2(0,0)

@export var bubble_body : Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	bubble_scale = bubble_body.scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inflate_bubble"):
		_start_inflate_bubble()
		
	if Input.is_action_just_released("inflate_bubble"):
		_stop_inflate_bubble()
		
	if Input.is_action_just_pressed("deflate_bubble"):
		_start_deflate_bubble()

	if Input.is_action_just_released("deflate_bubble"):
		_stop_deflate_bubble()
		
	pass

func _start_inflate_bubble():
	print("inflate bubble")

	bubble_body.apply_scale(Vector2(2,2))
	audio.instantiate_playback()

	bubble_scale = bubble_body.scale
	pass
	
func _stop_inflate_bubble():
#	audio.free()
	pass

func _start_deflate_bubble():
	print("deflate bubble")
	bubble_body.apply_scale(Vector2(.5,.5))
#	audio.instantiate_playback()
	pass

func _stop_deflate_bubble():
	print("deflate bubble")
#	audio.free()
	pass
	
	
