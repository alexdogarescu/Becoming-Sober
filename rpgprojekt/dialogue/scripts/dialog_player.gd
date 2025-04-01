extends CanvasLayer
@onready var text_bg = $Background
@onready var text_label =$Background/RichTextLabel
@onready var speaker_name = $Background2
@onready var speaker = $Sprite2D

var i = 0;
var scene_text
var selected_text: Array[String]
var in_progress = false


func _ready():
	self.visible = false
	
	SignalBus.display_dialog.connect(on_display_dialog)


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
		for line in lines:
			print("oi")
			i +=i
		show_text()


#for line in dialog_lines:
