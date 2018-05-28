# TileNode Class

var pos #Vector2
var g_cost #int
var f_cost #int
var parent #TileNode

func _init(pos, g_cost = 0, f_cost = 0, parent = null):
	self.pos = pos
	self.g_cost = g_cost
	self.f_cost = f_cost
	if parent == null:
		self.parent = self
	else:
		self.parent = parent