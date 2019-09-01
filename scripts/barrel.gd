extends Node2D

const LEFT = 1
const RIGHT = 2

onready var anim = self.get_node("Anim")

func _ready():
	pass

func destroy(side):
	if side == self.LEFT:
		anim.play("barrel-right")
		
	if side == self.RIGHT:
		anim.play("barrel-left")
