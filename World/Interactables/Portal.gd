extends Area2D

@export_file("*.tscn") var portal_exit
@export_file("*.tscn") var shadow_exit
@export var portal_spawn : Vector2

func _on_body_entered(body):
	if portal_exit and body.is_in_group("Player"):
		Global.change_level(portal_exit, shadow_exit, portal_spawn)
