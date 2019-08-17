#script: explosion
extends Sprite

func _ready():
	randomize()
	set_rot(deg2rad(rand_range(0, 360)))
	
	get_node("anim").play("fade_out")
	get_node("p_smoke").set_emitting(true)
	get_node("p_flare").set_emitting(true)
	
	utils.remote_call("camera", "shake", 8, 0.2)
	
	yield(get_node("anim"), "finished")
	queue_free()