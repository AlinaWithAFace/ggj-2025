extends Node2D

class_name Obstacle

enum ObstacleClass {
	LIGHTDAMAGE,
	HEAVYDAMAGE,
	DEATHDAMAGE,
}

@export var sprite : Sprite2D
@export var obstacle_type : ObstacleClass = ObstacleClass.LIGHTDAMAGE

@export var light_damage_node  : Node
@export var heavy_damage_node  : Node
@export var death_damage_node  : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	obstacle_type = ObstacleClass.values().pick_random()
	
	if(obstacle_type == ObstacleClass.LIGHTDAMAGE):
		light_damage_node.show()
		heavy_damage_node.hide()
		death_damage_node.hide()
	elif(obstacle_type == ObstacleClass.HEAVYDAMAGE):
		light_damage_node.hide()
		heavy_damage_node.show()
		death_damage_node.hide()
	elif(obstacle_type == ObstacleClass.DEATHDAMAGE):
		light_damage_node.hide()
		heavy_damage_node.hide()
		death_damage_node.show()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	return
	print("POPPPING")
	if(body.has_method("pop")):
		body.pop()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	return
	if(body.has_method("pop")):
		body.pop(self)
		#sprite.modulate = Color(1,0,0,1)
		pass
	print("entered")
	pass # Replace with function body.
