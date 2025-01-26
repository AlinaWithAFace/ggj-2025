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
@export var plankton_manager: ObstacleManager = null
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
			plankton_manager.started = true
		if(active_time > 60):
			finish_game()
			return
		var spriteY = 2048 - ((active_time/60.0) * 2048);
		var sz = bubble.size;
		sz +=1
		
		speed = sz * sz;
		distance += speed * delta
		
		var pos = backdrop.region_rect.position;
		pos.y = spriteY
		
		backdrop.region_rect.position = pos;
		
		
		plankton_manager.destroy_plankton(obstacle_manager.active_obstacles)
		obstacle_manager.test_collision(bubble, bubble.curr_scale * 100)

		plankton_manager.test_collision(bubble, bubble.curr_scale * 100)
		
		
		score_label.text = "Score: %s" % bubble.score
		print(bubble.linear_velocity)
	
	
func finish_game():
	if(started):
		speed = 0
		accel = 0
		bubble.velocity = Vector2.ZERO
		bubble.linear_velocity = Vector2.ZERO
		
		main_menu_node.show()
		started = false
		obstacle_manager.Cleanup()
		plankton_manager.Cleanup()
		active_time = 0


func _on_bubble_popped() -> void:
	return

	
func _on_texture_button_pressed() -> void:
	started = true
	main_menu_node.hide()
	bubble.show()
	bubble.reset()
	distance = 0
	active_time = 0
	obstacle_manager.Start()
	plankton_manager.Start()
	pass # Replace with function body.
