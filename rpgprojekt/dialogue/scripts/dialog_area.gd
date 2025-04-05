extends Area2D

@export var dialog_lines: Array[DialogLine]
@export var dialog_key = ""
var area_active = false
var already_pressed = true

func _input(event):
	if Dialogic.current_timeline != null:
		return
	var input = Input.is_action_just_pressed("e")
	if area_active and event.is_action_pressed("e"):
		await get_tree().create_timer(0.1).timeout
		Dialogic.start("timelinetest")
		get_viewport().set_input_as_handled()
		#DO SMTH ABOUT PAUSING
		

func _on_area_entered(area: Area2D) -> void:
	area_active = true

func _on_area_exited(area: Area2D) -> void:
	area_active = false



#SignalBus.emit_signal("display_dialog", dialog_lines)
#func _input(event: InputEvent):
	# check if a dialog is already running
	#if Dialogic.current_timeline != null:
		#return
	#var input = Input.is_action_just_pressed("e")
	#if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		#Dialogic.start("timelinetest")
		#get_viewport().set_input_as_handled()
