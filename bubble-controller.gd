extends RigidBody2D

class_name Bubble

@export var audio: AudioStream = null

@export var damaged : AudioStreamPlayer2D = null
@export var pickup : AudioStreamPlayer2D = null

@export var bubble_scale : Vector2 = Vector2(0,0)

@export var bubble_body : Node2D = null
@export var bubble_scale_root : Node2D = null;
@export var bubble_shape : CollisionShape2D = null;

@export var SCALE_SPEED : float = 8;

@export var MAGNITUDE = 1
@export var collider_scalar = 140
@export var max_scale = 1.2

@export var place_range: float = 40
@export var place_scale: float = .5
@export var obstacle_manager : ObstacleManager
@export var plankton_manager: ObstacleManager
@export var score_speed_multiplier = 1
@export var plankton_parent: Node2D = null

var score = 0

signal popped
var planktonians: Array = Array()


var size:
	get:
		return curr_scale


var curr_scale:float = 1
@export var target_scale:float = 1
var started: bool = false
var start_pos: Vector2 = Vector2.ZERO


var touch_points
var velocity: Vector2 = Vector2.ZERO
var touching 


func reset():
	target_scale = .5
	curr_scale = .5
	scale = Vector2.ONE
	started = true
	position = start_pos
	score = 0
	

func Cleanup():
	for p in planktonians:
		remove_child(p)
		p.queue_free
	planktonians = Array()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	bubble_scale = bubble_body.scale
	start_pos = position
	pass # Replace with function body.

var health : int = 3

var time: float = 0

var inflate_timer:float = 0
var deflate_timer:float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!started):
		return
	
	var spd = 50 + max(0,score_speed_multiplier*score)
	obstacle_manager.speed = spd
	plankton_manager.speed = spd
	
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
		
	if Input.is_action_just_pressed("move_up"):
		wave(Vector2(0, -2000))
	if Input.is_action_just_pressed("move_down"):
		wave(Vector2(0, 2000))
		
	time+=delta* 2;
	var sine_val:Vector2 = Vector2(sin(time), 0)
	target_scale = min(target_scale, max_scale)
	
	curr_scale = lerp(curr_scale, target_scale, delta * SCALE_SPEED)
	
	scale = Vector2(curr_scale, curr_scale)
	
	bubble_scale_root.scale = Vector2(curr_scale, curr_scale)
	((bubble_shape.shape) as CircleShape2D).radius = curr_scale * collider_scalar
	#var collision = move_and_collide(sine_val)
	#if collision:
	#	pop()
	
	for p in planktonians:
		p.bob(delta)
		
	pass

func _start_inflate_bubble():
	print("inflate bubble")
	target_scale *= 1.1;
	#audio.instantiate_playback()
	pickup.play()

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
	damaged.play()
	started = false
	popped.emit()
	
func damage():
	pass

func wave(direction : Vector2):
	apply_force(direction)
	
	pass
	
	
func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif event is InputEventScreenDrag:
		handle_drag(event)
	
	
func add_plankton(p:Plankton):
	score += 1
	pickup.play()
	
	p.get_parent().remove_child(p)
	plankton_parent.add_child(p)
	p.position = Vector2(randf()*place_range-(place_range/2), randf()*place_range - (place_range/2))
	p.scale = Vector2(place_scale, place_scale)
	p.PickedUp()
	
	planktonians.append(p)
	target_scale *= 1.1
	

func kill_plankton(obstacle: Obstacle):
	var to_kill = max(1,floor(score *.3))
	match ((obstacle as Obstacle).obstacle_type):
		Obstacle.ObstacleClass.LIGHTDAMAGE:
			to_kill = 1
		Obstacle.ObstacleClass.HEAVYDAMAGE:
			to_kill = 3
		Obstacle.ObstacleClass.DEATHDAMAGE:
			to_kill = 5
	score -= to_kill
	damaged.play()
	for i in range(to_kill):
		if(len(planktonians) > 0):
			target_scale *= .9

			var p = planktonians[0]
			var pos = p.global_position
			planktonians.remove_at(0)
			plankton_parent.remove_child(p)
			get_tree().root.add_child(p)
			p.global_position = pos
			p.falling = true
	check_game_over()

func check_game_over():
	if score < 0:
		get_tree().reload_current_scene()
		pass
		

func handle_touch(_event : InputEventScreenTouch) -> void:
	if _event.pressed:
		touching = true
	else:
		touching = false
		wave(velocity*MAGNITUDE)
		velocity*=0
	pass
	
func handle_drag(_event : InputEventScreenDrag):
	if(touching):
		velocity = _event.get_screen_velocity()
		print(velocity)
	pass
	
	
