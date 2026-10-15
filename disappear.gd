extends Label
@export var multiplier = 1
var font_size = 32
var time = 0

func _process(delta: float) -> void:
	time+=delta
	font_size -= time*multiplier
	add_theme_font_size_override("font_size",int(font_size))
	if int(font_size) <= 0:
		queue_free()
