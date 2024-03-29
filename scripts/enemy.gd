#script: enemy
extends Area2D

export var armor = 2 setget set_armor
export var velocty = Vector2()

const scn_explosion = preload("res://scenes/explosion.tscn")

func _ready():
	add_to_group("enemy")
	connect("area_enter", self, "_on_area_enter")
	set_process(true)

func _process(delta):
	translate(velocty * delta)
	
	if(get_pos().y-16 > get_viewport_rect().size.height):
		queue_free()

func _on_area_enter(other):
	if(other.is_in_group("ship")):
		other.armor -= 1
		create_explosion()
		queue_free()

func set_armor(new_value):
	if(is_queued_for_deletion()): return
	armor = new_value
	if armor <= 0:
		create_explosion()
		queue_free()

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.set_pos(get_pos())
	utils.main_node.add_child(explosion)