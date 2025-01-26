extends Node2D
class_name Plankton


var rng = RandomNumberGenerator.new()
@export var array : Array
@export var bobSpeed: float = 2
@export var bobScale: float = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = array[rng.randi_range(0, array.size()-1)]
	get_node(temp).show()
	pass # Replace with function body.

var pos:Vector2
var time: float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
