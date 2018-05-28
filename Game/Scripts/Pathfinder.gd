extends Node

const TileNode = preload("res://Scripts/TileNode.gd")
var open_list
var closed_list


### Helper Functions ###



### End Helper Functions ###


# A* Pathfinding
func find_path(start, finish, map):
	# If start is finish there's no path to return
	if start == finish:
		return []
	
	# Add start to open_list to start the proccess
	open_list = []
	open_list.push_back