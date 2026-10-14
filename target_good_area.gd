extends Area2D
var is_colliding = false
var score = 0
@export var score_label:Label
signal hit
signal reset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and not is_colliding:
		score = 0
		reset.emit()
		print("test")
	if Input.is_action_just_pressed("click") and is_colliding:
		score+=1
		is_colliding = false
		hit.emit()
		
	score_label.text = "score: "+ str(score)


func _on_body_entered(body: Node2D) -> void:
	is_colliding = true
	$Sprite2D.frame = 5


func _on_body_exited(body: Node2D) -> void:
	is_colliding = false
	$Sprite2D.frame = 0
