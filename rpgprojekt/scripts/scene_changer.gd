#make it autoload(global)
extends CanvasLayer

var new_scene_path: String
#var battle_path = "res://scenes/battle_scene.tscn"
@onready var color_rect = $ColorRect

#Why do I have to do this ready func? Is there a way without it?
func _ready():
	color_rect.modulate.a = 0
	
func change_to(scene_path):
	print("change to", scene_path)
	new_scene_path = scene_path
	
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play("fade_in_out")


func _new_scene():
	get_tree().call_deferred("change_scene_to_file", new_scene_path)
