extends Node2D

class_name Root

@export var speed: float = 0
@export var distance: float = 0
@export var accel: float = 0
@export var backdrop: Sprite2D = null

@export var bubble: Bubble = null
@export var start_button: TextureButton = null
@export var score_label: Label = null
@export var speed_scale: float = 5
@export var obstacle_manager: ObstacleManager = null
var started = false

var active_time : float = 0

@export var main_menu_node : Node2D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 0;
	distance = 0;
	#gameover.hide()
	
	bubble.hide()
	start_button.show()
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(started):
		active_time+= delta
		if(active_time > 3):
			obstacle_manager.started = true
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
		bubble.velocity = Vector2.ZERO
		bubble.linear_velocity = Vector2.ZERO
		
		bubble.hide()
		main_menu_node.show()
		started = false
		obstacle_manager.Cleanup()
		active_time = 0
		
		
	
	pass # Replace with function body.

func _on_texture_button_pressed() -> void:
	started = true
	main_menu_node.hide()
	bubble.show()
	bubble.reset()
	distance = 0
	active_time = 0
	pass # Replace with function body.
