extends CanvasLayer
@onready var text_bg = $Background
@onready var text_label =$Background/RichTextLabel
@onready var speaker_name = $RichTextLabel
@onready var speaker = $Sprite2D


var scene_text
var selected_text: Array[String]
var in_progress = false


func _ready():
	self.visible = false
	#Dialogic.get_node("/root/DialogicUi").hide()
	#Dialogic.signal_event.connect(_on_dialogic_signal)
	SignalBus.display_dialog.connect(on_display_dialog)

#func _on_dialogic_signal(event):
	#if event["event_id"] == "dialog_text":
		#var text = event.get("text", "")
		#text_label.text = text
		#print(text)
	

func next_line():
	if selected_text.size() >0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	self.visible = false
	in_progress = false
	get_tree().paused = false

func show_text():
	#text_label.text = selected_text.pop_front()
	print("this is show text function")

func on_display_dialog(lines: Array[DialogLine]):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		self.visible = true
		in_progress = true
		print("dialog")
		#selected_text = scene_text[]
		#show_text
		for line in lines:
			print("oi")
		show_text()

#for line in dialog_lines:
