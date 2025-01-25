extends Node2D

class_name Root

@export var speed: float = 0
@export var distance: float = 0
@export var accel: float = 0
@export var backdrop: Sprite2D = null
@export var gameover: Sprite2D = null
@export var bubble: Bubble = null
@export var start_button: TextureButton = null
@export var score_label: Label = null
@export var speed_scale: float = 5
var started = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 0;
	distance = 0;
	gameover.hide()
	
	bubble.hide()
	start_button.show()
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(started):
		var spriteY = 1000 - distance;
		var sz = bubble.size;
		sz +=1
		
		speed = sz * sz;
		distance += speed * delta
		
		var pos = backdrop.region_rect.position;
		pos.y = spriteY
		
		backdrop.region_rect.position = pos;
		score_label.text = "Score: %s" % floor(distance)


func _on_bubble_popped() -> void:
	if(started):
		speed = 0
		accel = 0
		#gameover.show()
		bubble.hide()
		start_button.show()
		started = false
		
	
	pass # Replace with function body.

func _on_texture_button_pressed() -> void:
	started = true
	gameover.hide()
	start_button.hide()
	bubble.show()
	bubble.reset()
	distance = 0
	pass # Replace with function body.
