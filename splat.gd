extends RigidBody2D

@export var targets = []

var current_target_path
var current_target

func _ready() -> void:
	current_target_path = targets[randi_range(0,1)]
	current_target = get_node(current_target_path)

func _process(delta: float) -> void:
	var movement = Vector2(lerpf(position.x, current_target.position.x,2), lerpf(position.x, current_target.position.x,2))
	move_and_collide(movement)
