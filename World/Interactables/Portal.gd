extends Area2D

@export_file("*.tscn") var portal_exit
@export var portal_spawn : Vector2

func _on_body_entered(body):
	if portal_exit and body.is_in_group("Player"):
		get_tree().change_scene_to_file(portal_exit)
		Global.character_position = portal_spawn
