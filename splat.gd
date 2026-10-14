extends RigidBody2D

@export var targets = []
@export var good_zone: Node2D
var i = 0
var y_range = [20,340]
var current_target
var speed = 2

func _ready() -> void:
	i = randi_range(0,1)
	current_target = get_node(targets[i])

func _process(delta: float) -> void:
	var movement = Vector2(current_target.position.x-position.x, current_target.position.y-position.y).normalized()*speed
	move_and_collide(movement)

func _on_spot_1_body_entered(body: Node2D) -> void:
	i+=1
	i%=2
	get_node(targets[i]).position.y = randi_range(y_range[0],y_range[1]) 
	good_zone.position.y = get_average_y_targets()
	current_target = get_node(targets[i])
	
func get_average_y_targets() -> float:
	return (get_node(targets[0]).position.y+get_node(targets[1]).position.y)/2


func _on_target_good_area_hit() -> void:
	if speed < 10:
		speed+=1


func _on_target_good_area_reset() -> void:
	speed = 2
