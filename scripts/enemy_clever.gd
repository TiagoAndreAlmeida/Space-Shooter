#script: enemy clever
extends "res://scripts/enemy.gd"

const scn_laser = preload("res://scenes/laser_enemy.tscn")

func _ready():
	velocty.x = utils.choose([velocty.x, -velocty.x])
	
	yield(utils.create_timer(1), "timeout")
	shoot()

func _process(delta):
	if(get_pos().x < 16):
		velocty.x = abs(velocty.x)
	elif(get_pos().x > utils.view_size.width-16):
		velocty.x = -abs(velocty.x)

func shoot():
	while true:
		var laser = scn_laser.instance()
		laser.set_pos(get_node("cannor").get_global_pos())
		utils.main_node.add_child(laser)
		
		yield(utils.create_timer(1.5), "timeout")