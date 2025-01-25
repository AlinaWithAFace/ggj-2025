extends RigidBody2D

class_name Bubble

@export var audio: AudioStream = null

@export var bubble_scale : Vector2 = Vector2(0,0)

@export var bubble_body : Node2D = null
@export var bubble_shape : CollisionShape2D = null;

@export var SCALE_SPEED : float = 8;



signal popped

var size:
	get:
		return curr_scale


var curr_scale:float = 1
var target_scale:float = 1
var started: bool = false
var start_pos: Vector2 = Vector2.ZERO


func reset():
	target_scale = .5
	curr_scale = .5
	scale = Vector2.ONE
	started = true
	position = start_pos
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	bubble_scale = bubble_body.scale
	start_pos = position
	pass # Replace with function body.


var time: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!started):
		return
	
	if Input.is_action_just_pressed("inflate_bubble"):
		_start_inflate_bubble()
		
	if Input.is_action_just_released("inflate_bubble"):
		_stop_inflate_bubble()
		
	if Input.is_action_just_pressed("deflate_bubble"):
		_start_deflate_bubble()

	if Input.is_action_just_released("deflate_bubble"):
		_stop_deflate_bubble()
		
	if Input.is_action_just_pressed("move_right"):
		wave(Vector2(2000, 0))
	if Input.is_action_just_pressed("move_left"):
		wave(Vector2(-2000, 0))
		
	time+=delta* 2;
	var sine_val:Vector2 = Vector2(sin(time), 0)
	
	curr_scale = lerp(curr_scale, target_scale, delta * SCALE_SPEED)
	
	scale = Vector2(curr_scale, curr_scale)
	
	#var collision = move_and_collide(sine_val)
	#if collision:
	#	pop()
	
	pass

func _start_inflate_bubble():
	print("inflate bubble")

	target_scale *= 1.3;
	
	audio.instantiate_playback()

	bubble_scale = bubble_body.scale
	pass
	
func _stop_inflate_bubble():
#	audio.free()
	pass

func _start_deflate_bubble():
	print("deflate bubble")
	target_scale *= 0.8 
#	audio.instantiate_playback()
	pass

func _stop_deflate_bubble():
	print("deflate bubble")
#	audio.free()
	pass
	
func pop():
	started = false
	popped.emit()
	
func wave(direction : Vector2):
	apply_force(direction)
	print("hello")
	pass
	
	
	
	
