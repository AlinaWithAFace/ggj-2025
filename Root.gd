extends Node2D

@export var speed: float = 0
@export var distance: float = 0
@export var accel: float = 0
@export var backdrop: Sprite2D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 0;
	distance = 0;
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var spriteY = 400 - distance;
	speed += accel * delta
	distance += speed * delta
	print(distance)
	
	var pos = backdrop.region_rect.position;
	pos.y = spriteY
	
	backdrop.region_rect.position = pos;
