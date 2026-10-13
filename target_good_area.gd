extends Area2D
var is_colliding = false
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		score+=1
		is_colliding = false


func _on_body_entered(body: Node2D) -> void:
	is_colliding = true


func _on_body_exited(body: Node2D) -> void:
	is_colliding = false
