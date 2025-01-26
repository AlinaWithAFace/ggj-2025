extends Node2D
class_name Plankton


var rng = RandomNumberGenerator.new()
@export var array : Array
@export var bobSpeed: float = 2
@export var bobScale: float = 10
@export var fall_speed: float = 4
var falling:bool = false
var speed: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = array[rng.randi_range(0, array.size()-1)]
	get_node(temp).show()
	pass # Replace with function body.

var pos:Vector2
var time: float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(falling):
		speed += delta * fall_speed
		global_position = Vector2(global_position.x, global_position.y + speed * delta)

func bob(delta:float):
	time += delta * bobSpeed
	position = Vector2(pos.x, pos.y + sin(time)*bobScale)

func PickedUp():
	pos = position
	$Area2D.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	#TODO
	#increment score
	#put plankton in bubble to vibe
	
	pass # Replace with function body.
