extends Node2D

onready var ze_timber = self.get_node("ZeTimber")
onready var camera = self.get_node("Camera")

func _ready():
	set_process_input(true)

func _input(event):
	# convert the device dimensions to default
	event = camera.make_input_local(event)
	
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		
		if event.pos.x < 360:
			ze_timber.moveToLeft()
		else:
			ze_timber.moveToRight()
		
		ze_timber.hit()
