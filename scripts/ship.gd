#script: ship
extends Area2D

export var armor = 4 setget set_armor
const scn_laser = preload("res://scenes/laser_ship.tscn")
const scn_explosion = preload("res://scenes/explosion.tscn")
const scn_flash = preload("res://scenes/flash.tscn")

func _ready():
	set_process(true)
	add_to_group("ship")
	yield(utils.create_timer(0.5), "timeout")
	shoot()

func _process(delta):
	#criando suavização de movimento
	var motion = (get_global_mouse_pos().x - get_pos().x) * 0.2
	translate(Vector2(motion, 0))
	#setando um range minimo e maximo que a nave pode ir
	var pos = get_pos()
	pos.x = clamp(get_pos().x, 16, get_viewport_rect().size.x - 16)
	set_pos(pos)

func shoot():
	while true:
		var left = get_node("cannons/left").get_global_pos()
		var right = get_node("cannons/right").get_global_pos()
		create_laser(left)
		create_laser(right)
		
		yield(utils.create_timer(0.25), "timeout")

func set_armor(new_value):
	if(new_value < armor):
		utils.main_node.add_child(scn_flash.instance())
	armor = new_value
	if armor <= 0: 
		create_explosion()
		queue_free()

func create_laser(pos):
	var laser = scn_laser.instance()
	laser.set_pos(pos)
	utils.main_node.add_child(laser)
	
func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.set_pos(get_pos())
	utils.main_node.add_child(explosion)