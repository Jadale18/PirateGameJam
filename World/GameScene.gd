extends Control

@onready var characters := {
	"character": {
		viewport = $"VBoxContainer/TopViewportContainer/TopViewport",
		camera = $"VBoxContainer/TopViewportContainer/TopViewport/Camera2D",
		character = $VBoxContainer/TopViewportContainer/TopViewport/Level1/Character,
	},
	"shadow": {
		viewport = $"VBoxContainer/BottomViewportContainer/BottomViewport",
		camera = $"VBoxContainer/BottomViewportContainer/BottomViewport/Camera2D",
		character = $VBoxContainer/BottomViewportContainer/BottomViewport/ShadowLevel1/Shadow
	}
}

func _ready() -> void:
	for node in characters.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.character.add_child(remote_transform)
	
