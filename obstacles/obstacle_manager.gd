extends Node2D
@export var width = 0
@export var max_obstacles = 10
@export var max_distance = 100
var active_obstacles
var cached_obstacles
var speed
var packed_obstacle = preload("res://obstacles/spike_ball.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 0
	active_obstacles = Array()
	cached_obstacles = Array()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for obstacle in active_obstacles :
		obstacle.y += speed*delta
		if obstacle.y > max_distance:
			cached_obstacles.add(obstacle)
			active_obstacles.remove(obstacle)
			
	pass


func _on_timer_timeout() -> void:
	if(active_obstacles.size < max_obstacles):
		if(!cached_obstacles.is_empty()):
			var temp = cached_obstacles.get(0)
			cached_obstacles.remove(0)
			place_obstacle(temp)
			pass
		else:
			var temp = packed_obstacle.instantiate()
			add_child(temp)
			place_obstacle(temp)
			pass
	pass # Replace with function body.
	
func place_obstacle(ob):
	ob.x = rng.randf_range(-width/2, width/2)
	ob.y = self.y
	active_obstacles.add(ob)
	pass
