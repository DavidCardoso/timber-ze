extends Node2D

const MARKER_SPEED = 0.1
const MARKER_WIDTH = 188
const MARKER_HEIGHT = 23

signal lost

var percentage = 1

onready var marker = self.get_node("Marker")

func _ready():
	set_process(true)

func _process(delta):
	if percentage > 0:
		percentage -= self.MARKER_SPEED * delta
		marker.set_region_rect(Rect2(0, 0, percentage*self.MARKER_WIDTH, self.MARKER_HEIGHT))
		marker.set_pos(Vector2(-(1-percentage) * self.MARKER_WIDTH/2, 0))
	else:
		emit_signal("lost")

func add(delta):
	percentage += delta
	if percentage > 1:
		percentage = 1
