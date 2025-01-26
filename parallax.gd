extends Node2D
@export var p1 : Sprite2D
@export var p2 : Sprite2D
@export var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	p1.position.y+=delta*speed
	p2.position.y += delta*speed
	
	if p1.position.y > p1.texture.get_height():
		p1.position.y = - p1.texture.get_height()
	if p2.position.y > p2.texture.get_height():
		p2.position.y = - p2.texture.get_height()
	pass
