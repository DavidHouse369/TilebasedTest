tool
extends AnimatedSprite

export(Vector2) var alive_pos = Vector2(0, 0)
export(Vector2) var dead_pos = Vector2(150, 15)

func _ready():
	get_parent().connect("state_changed", self, "on_state_changed")

func on_state_changed(is_alive):
	if is_alive:
		set_offset(alive_pos)
		play("idle")
	else:
		set_offset(dead_pos)
		play("die")