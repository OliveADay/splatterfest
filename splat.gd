extends RigidBody2D

@export var targets = []
@export var good_zone: Node2D
@export var dead_canvas:CanvasLayer
var little_one_resource = preload("res://+1.tscn")
var static_splat_resource = preload("res://splat_static.tscn")
var static_splats = []
var i = 0
var y_range = [20,340]
var current_target
var start_speed = 2
var speed = 0

func _ready() -> void:
	speed = start_speed
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
	good_zone.position.x = 323.0+randi_range(-20,20)
	current_target = get_node(targets[i])
	$bounce.play()
	
func get_average_y_targets() -> float:
	return (get_node(targets[0]).position.y+get_node(targets[1]).position.y)/2


func _on_target_good_area_hit() -> void:
	if speed < 10:
		speed+=0.5
	$Sprite2D.frame = int(speed/3)+1
	var little_one = little_one_resource.instantiate()
	get_tree().root.add_child(little_one)
	little_one.position = position
	var static_splat = static_splat_resource.instantiate()
	get_tree().root.add_child(static_splat)
	static_splat.position = position
	static_splat.frame =  $Sprite2D.frame
	static_splats.append(static_splat)
	$score.play()


func _on_target_good_area_reset() -> void:
	speed = 0
	dead_canvas.visible = true
	var i = 0
	for splat in static_splats:
		splat.queue_free()
		static_splats.remove_at(i)
		i+=1
	dead_canvas.process_mode = Node.PROCESS_MODE_INHERIT
	
