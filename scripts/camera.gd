#script: camera
extends Camera2D

var magnitude = 0
var timeleft  = 0
var shaking   = false

func _ready():
	
	pass

func shake(new_mag, lifetime):
	#dont override minos values
	if (magnitude > new_mag): return
	
	magnitude = new_mag
	timeleft  = lifetime
	
	#only call function once time
	if shaking: return
	shaking = true
	
	
	while timeleft > 0:
		var pos = Vector2()
		pos.x = rand_range(-magnitude, magnitude)
		pos.y = rand_range(-magnitude, magnitude)
		set_pos(pos)
		
		timeleft -= get_process_delta_time()
		yield(get_tree(), "idle_frame")
	
	#set values to default
	magnitude = 0
	shaking = false
	set_pos(Vector2(0,0))