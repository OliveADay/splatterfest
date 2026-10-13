extends RigidBody2D

@export var targets = []
var i = 0
var y_range = [20,340]
var current_target

func _ready() -> void:
	i = randi_range(0,1)
	current_target = get_node(targets[i])

func _process(delta: float) -> void:
	var movement = Vector2(current_target.position.x-position.x, current_target.position.y-position.y).normalized()*2
	move_and_collide(movement)

func _on_spot_1_body_entered(body: Node2D) -> void:
	i+=1
	i%=2
	get_node(targets[i]).position.y = randi_range(y_range[0],y_range[1]) 
	current_target = get_node(targets[i])
