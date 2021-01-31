extends Node2D

export (PackedScene) var Player

func _ready():
	var p = Player.instance()
	add_child(p)
	p.position = $PlayerSpawner.global_position
