extends Node2D

const LEFT = 1
const RIGHT = 2

var side = self.LEFT

onready var idle = self.get_node("Idle")
onready var hitting = self.get_node("Hitting")
onready var grave = self.get_node("Grave")
onready var anim = self.get_node("Anim")

func _ready():
	pass

func move_to_left():
	self.set_pos(Vector2(220, 1070))
	
	idle.set_flip_h(false)
	hitting.set_flip_h(false)
	
	grave.set_pos(Vector2(-44, 41))
	grave.set_flip_h(true)
	side = self.LEFT

func move_to_right():
	self.set_pos(Vector2(500, 1070))
	
	idle.set_flip_h(true)
	hitting.set_flip_h(true)

	grave.set_pos(Vector2(28, 41))
	grave.set_flip_h(false)
	side = self.RIGHT

func hit():
	anim.play("Hit")

func die():
	anim.stop()
	idle.hide()
	hitting.hide()
	grave.show()