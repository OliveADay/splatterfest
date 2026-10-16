extends CanvasLayer
@export var text_bits = ["bleh", "grah"]
var current_bit = text_bits[0]
var i = 0;
var j = 0;
var typing = true
@export var step_time = 0.05
var current_time = 0
var vowels = ['a','e','o','u','i']
@export var label:Label
@export var sprite: Sprite2D
@export var frame_0 = 0
@export var frame_1 = 1
@export var talk_sound: AudioStreamPlayer2D
var max_wait_before_clickable = 1

func _ready() -> void:
	get_tree().paused = true
	label.text = ""

func _process(delta: float) -> void:
	if text_bits.size() > j:
		current_bit = text_bits[j]
		if current_time <= 0 and typing:
			label.text+=current_bit[i]
			if is_vowel(current_bit[i]):
				sprite.frame = frame_0
				talk_sound.play()
			else:
				sprite.frame = frame_1
			i+=1
			if current_bit.length() == i:
				typing = false
			current_time = step_time
		else:
			current_time-=delta
	if Input.is_action_just_pressed("click") and max_wait_before_clickable <=0:
		if typing:
			label.text = current_bit
			typing = false
		else:
			j+=1
			if text_bits.size() > j:
				label.text = ""
				typing = true
				i = 0
	else:
		max_wait_before_clickable -=delta
				
func is_vowel(thingy) -> bool:
	for letter in vowels:
		if letter == thingy:
			return true
	return false 
