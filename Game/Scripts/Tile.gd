tool 
extends Node2D


export(Vector3) var tileScale = Vector3(1, 0.75, 0.5) setget OnScaleChange
export(float) var tilePixelSize = 64 setget OnPixelSizeChange
export(Color) var tileColor = Color(1, 1, 1) setget OnColorChange
export(bool) var setUGColorAutomatically = true setget OnAutoChange
export(Color) var ugLeftColor = tileColor.linear_interpolate(Color(0, 0, 0, tileColor.a), 0.3) setget OnUGLeftColorChange
export(Color) var ugRightColor = tileColor.linear_interpolate(Color(0, 0, 0, tileColor.a), 0.6) setget OnUGRightColorChange
export(bool) var useOutline = true setget OnUseOutlineChange
export(Color) var outlineColor = Color(0, 0, 0) setget OnOutlineColorChange
var surfacePoints = PoolVector2Array()
var ugLeftPoints = PoolVector2Array()
var ugRightPoints = PoolVector2Array()

func _ready():
	ReloadPoolVector2Arrays()

func _draw():
	draw_colored_polygon(surfacePoints, tileColor)
	draw_colored_polygon(ugLeftPoints, ugLeftColor)
	draw_colored_polygon(ugRightPoints, ugRightColor)
	if useOutline:
		DrawOutline(surfacePoints, outlineColor)
		DrawOutline(ugLeftPoints, outlineColor)
		DrawOutline(ugRightPoints, outlineColor)

func ReloadPoolVector2Arrays():
	var tileSize = tileScale * tilePixelSize
	var yOffset = tilePixelSize * 0.5 - tileSize.z
	
	surfacePoints = PoolVector2Array()
	surfacePoints.push_back(Vector2(-tileSize.x*0.5, yOffset))
	surfacePoints.push_back(Vector2(0, yOffset + tileSize.y*0.5))
	surfacePoints.push_back(Vector2(tileSize.x*0.5, yOffset))
	surfacePoints.push_back(Vector2(0, yOffset - tileSize.y*0.5))
	
	ugLeftPoints = PoolVector2Array()
	ugLeftPoints.push_back(Vector2(-tileSize.x*0.5, yOffset))
	ugLeftPoints.push_back(Vector2(0, yOffset + tileSize.y*0.5))
	ugLeftPoints.push_back(Vector2(0, yOffset + tileSize.y*0.5 + tileSize.z))
	ugLeftPoints.push_back(Vector2(-tileSize.x*0.5, yOffset + tileSize.z))
	
	ugRightPoints = PoolVector2Array()
	ugRightPoints.push_back(Vector2(0, yOffset + tileSize.y*0.5))
	ugRightPoints.push_back(Vector2(tileSize.x*0.5, yOffset))
	ugRightPoints.push_back(Vector2(tileSize.x*0.5, yOffset + tileSize.z))
	ugRightPoints.push_back(Vector2(0, yOffset + tileSize.y*0.5 + tileSize.z))

func OnScaleChange(newVar):
	tileScale = newVar
	ReloadPoolVector2Arrays()
	update()

func OnPixelSizeChange(newVar):
	tilePixelSize = newVar
	ReloadPoolVector2Arrays()
	update()

func OnColorChange(newVar):
	tileColor = newVar
	if setUGColorAutomatically:
		ugLeftColor = tileColor.linear_interpolate(Color(0, 0, 0, tileColor.a), 0.3)
		ugRightColor = tileColor.linear_interpolate(Color(0, 0, 0, tileColor.a), 0.6)
	update()

func OnAutoChange(newVar):
	setUGColorAutomatically = newVar
	OnColorChange(tileColor)
	update()

func OnUGLeftColorChange(newVar):
	if !setUGColorAutomatically:
		ugLeftColor = newVar
		update()

func OnUGRightColorChange(newVar):
	if !setUGColorAutomatically:
		ugRightColor = newVar
		update()

func OnUseOutlineChange(newVar):
	useOutline = newVar
	update()

func OnOutlineColorChange(newVar):
	outlineColor = newVar
	if useOutline:
		update()

func DrawOutline(points, colorToUse):
	for i in range(points.size()):
		if i == points.size() - 1:
			draw_line(points[i], points[0], colorToUse)
		else:
			draw_line(points[i], points[i + 1], colorToUse)