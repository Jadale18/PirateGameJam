extends Node2D

func _ready():
	$Character.gravity_multiplier *= scale.y
	$Character.gravity *= scale.y

