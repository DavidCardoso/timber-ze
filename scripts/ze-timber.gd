extends Node2D

const LEFT = -1
const RIGHT = 1

var side = self.LEFT

onready var idle = self.get_node("Idle")
onready var hit = self.get_node("Hitting")
onready var grave = self.get_node("Grave")
onready var anim = self.get_node("Anim")

func _ready():
	pass

func moveToLeft():
	self.set_pos(Vector2(220, 1070))
	
	idle.set_flip_h(false)
	hit.set_flip_h(false)
	
	grave.set_pos(Vector2(-44, 41))
	grave.set_flip_h(true)
	self.side = self.LEFT

func moveToRight():
	self.set_pos(Vector2(500, 1070))
	
	idle.set_flip_h(true)
	hit.set_flip_h(true)
	
	grave.set_pos(Vector2(28, 41))
	grave.set_flip_h(false)
	self.side = self.RIGHT

func hit():
	self.anim.play("Hit")
