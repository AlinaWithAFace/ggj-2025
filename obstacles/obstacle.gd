extends Node2D
@export var sprite : NodePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_rigid_body_2d_body_entered(body: Node) -> void:
	print("POPPPING")
	if(body.has_method("pop")):
		body.pop()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.has_method("pop")):
		body.pop()
		hide()
		pass
	print("entered")
	pass # Replace with function body.
