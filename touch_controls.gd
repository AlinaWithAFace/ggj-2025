extends Node2D

#var touch_points : Dicti


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

	
#func _input(event):
#	if event is InputEventScreenTouch:
#		handle_touch(event)
		
		
	
#func handle_touch(_event : InputEventScreenTouch) -> void:
#	if _event.pressed:
#		touched_points[_event.index] = _event.position




### Variables
#@export var trailLine : Line2D
#var canSlice : bool = true
#var touch_points : Dictionary = {}
#
#
#func _input(event):
#	if event is InputEventScreenTouch: # Get initial touch
#		handle_touch(event)
#	elif event is InputEventScreenDrag: # Follow drag/swipe
#		handle_drag(event)
#
#
#func handle_touch(_event : InputEventScreenTouch) -> void: # Store touch position
#	if _event.pressed:
#		touch_points[_event.index] = _event.position
#		trailLine.add_point(_event.position)
#	else:
#		touch_points.erase(_event.index)
#		trailLine.clear_points() # Reset line 2d when finger lifted
#
#
#func handle_drag(_event : InputEventScreenDrag) -> void: # Store drag positions
#	touch_points[_event.index] = _event.position
#
#	if touch_points.size() == 1:
#		if canSlice:
#			trailLine.add_point(_event.position) # Add to line2d
#			print("SLICING")