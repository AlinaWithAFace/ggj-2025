extends Node2D
class_name ObstacleManager


@export var width = 0
@export var max_obstacles = 10
@export var max_distance = 100
@export var spawn_height = 0
var timer: Timer
var active_obstacles
@export var obstacle_radius: float = 30
@export var plankton_radius: float = 50
@export var speed = 0
@export var obj = "res://obstacles/spike_ball.tscn"
var packed_obstacle
var rng = RandomNumberGenerator.new()
var temp

@export var plankton = false

var started:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = $Timer
	active_obstacles = Array()
	packed_obstacle = load(obj)
	pass # Replace with function body.
	
	
func Start():
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!started):
		return
		
	for obstacle in active_obstacles :
		obstacle.position.y += speed*delta
		if obstacle.position.y > max_distance:
			place_obstacle(obstacle)
			pass
	pass
	

func Cleanup():
	started = false
	for node in active_obstacles:
		remove_child(node)
		node.queue_free()
		pass
	active_obstacles.clear()
	timer.stop()
	

func _on_timer_timeout() -> void:
	if(active_obstacles.size() < max_obstacles):
		var temp = packed_obstacle.instantiate()
		add_child(temp)
		active_obstacles.append(temp)
		place_obstacle(temp)

		pass
			
	
	pass # Replace with function body.
	
func place_obstacle(ob):
	rng.seed = Time.get_unix_time_from_system()
	ob.position.x = rng.randf_range(-width/2, width/2)
	ob.position.y = spawn_height
	pass



func destroy_plankton(obstacles):
	var radSum: float = plankton_radius + obstacle_radius
	for obstacle in obstacles:
		for plank in active_obstacles:
			var dist: float = (plank.global_position - obstacle.global_position).length()
			if(radSum > dist):
				active_obstacles.remove_at(active_obstacles.find(plank))
				remove_child(plank)
				plank.queue_free()

func test_collision(bubble: Bubble, bubble_size:float):
	var bubble_pos = bubble.position
	var rad = obstacle_radius
	if(plankton):
		rad = plankton_radius
	var working: Array = Array(active_obstacles)
	for obstacle in working:
		var radSum: float = bubble_size + rad
		var dist: float = (bubble_pos - obstacle.global_position).length()
		
		#print("Testing %s vs %s"%[radSum, dist])
		if(radSum > dist):
			if(plankton):
				bubble.add_plankton(obstacle as Plankton)
				active_obstacles.remove_at(active_obstacles.find(obstacle))
				remove_child(obstacle)
				obstacle.queue_free()
			else:
				active_obstacles.remove_at(active_obstacles.find(obstacle))
				remove_child(obstacle)
				obstacle.queue_free()
				bubble.kill_plankton()	
			
			
		
