extends Node2D

var rng = RandomNumberGenerator.new()
@export var array : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = array[rng.randi_range(0, array.size()-1)]
	get_node(temp).show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	#TODO
	#increment score
	#put plankton in bubble to vibe
	
	pass # Replace with function body.
