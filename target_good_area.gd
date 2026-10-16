extends Area2D
var is_colliding = false
var score = 0
@export var score_label:Label
var score_file_path = "user://score.cfg"
var best_score = 0
signal hit
signal reset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	best_score = load_best_score()
	if Input.is_action_just_pressed("click") and not is_colliding:
		score = 0
		reset.emit()
		print("test")
	if Input.is_action_just_pressed("click") and is_colliding:
		score+=1
		if score > best_score:
			best_score = score
			save_best_score(score)
		is_colliding = false
		hit.emit()
		
	score_label.text = "score: "+ str(score)


func _on_body_entered(body: Node2D) -> void:
	is_colliding = true
	$Sprite2D.frame = 5


func _on_body_exited(body: Node2D) -> void:
	is_colliding = false
	$Sprite2D.frame = 0
	
func save_best_score(score):
	var config = ConfigFile.new()
	config.set_value("main","best_score",score)
	config.save(score_file_path)
	
func load_best_score() -> int:
	var config = ConfigFile.new()
	var error = config.load(score_file_path)
	if error!=OK:
		return 0
	return config.get_value("main","best_score")
