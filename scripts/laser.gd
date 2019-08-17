#script: laser
extends Area2D

export var velocity = Vector2()
const flare_scn = preload("res://scenes/flare.tscn")

func _ready():
	set_process(true)
	create_flare()
	yield(get_node("vis_notifier"), "exit_screen")
	queue_free()

func _process(delta):
	translate(delta * velocity)
	
func create_flare():
	var flare = flare_scn.instance()
	flare.set_pos(get_pos())
	utils.main_node.add_child(flare)