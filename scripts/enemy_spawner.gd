#script: enemy spawner
extends Node

const enemies = [
	preload("res://scenes/enemy_kamikaze.tscn"),
	preload("res://scenes/enemy_clever.tscn")
]

func _ready():
	spawn()
	pass

func spawn():
	while true:
		randomize()
		
		var enemy = utils.choose(enemies).instance()
		var pos = Vector2()
		pos.x = rand_range(16, utils._get_view_size().width - 16)
		pos.y = -16
		enemy.set_pos(pos)
		get_node("container").add_child(enemy)
		
		yield(utils.create_timer(rand_range(0.5, 1.25)), "timeout")
	pass