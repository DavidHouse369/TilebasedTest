tool
extends Node2D


signal state_changed

onready var path_finder = get_parent().get_node("Pathfinder")

export(Vector2) var pos = Vector2(0, 0)
export(int) var move_dist = 3
export(int) var min_range = 1
export(int) var max_range = 1
export(bool) var is_alive = true setget on_is_alive_changed



func _input(event):
	if event is InputEventScreenTouch:
		if event.index == 0 and !event.pressed:
			# Create an input action for tapping
			var ev = InputEventAction.new()
			ev.action = "game_click"
			ev.pressed = false
			Input.parse_input_event(ev)

func _process(delta):
	# Process input
	if Input.is_action_just_released("game_click"):
		#path_finder.find_path(0, 0, 0)
		on_is_alive_changed(!is_alive)

func on_is_alive_changed(value):
	is_alive = value
	emit_signal("state_changed", is_alive)