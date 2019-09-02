extends Node2D

const LEFT = 1
const RIGHT = 2
const HEIGHT_BARREL = 172
const POS_Y_INI_BARREL = 1090
const HALF_SCREEN = 360
const TIME_BONUS = 0.014

var last_enemy = false
var playing = true

var barrelTypes = {
	"normal" : preload("res://scenes/barrel.tscn"),
	"left" : preload("res://scenes/barrel-left.tscn"),
	"right" : preload("res://scenes/barrel-right.tscn")
}

onready var zeTimber = self.get_node("ZeTimber")
onready var camera = self.get_node("Camera")
onready var barrels = self.get_node("Barrels")
onready var destroyedBarrels = self.get_node("DestroyedBarrels")
onready var timeMarker = self.get_node("TimeMarker")

func _ready():
	randomize()
	init_barrels()
	timeMarker.connect("lost", self, "lose")
	set_process_input(true)

func _input(event):
	# convert the device dimensions to default
	event = camera.make_input_local(event)
	
	if self.playing == true and event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		
		# move the character
		if event.pos.x < self.HALF_SCREEN:
			zeTimber.move_to_left()
		else:
			zeTimber.move_to_right()
		
		# hit a barrel
		if !check_collision():
			zeTimber.hit()
			
			var first_barrel = barrels.get_children()[0]
			
			barrels.remove_child(first_barrel)
			
			destroyedBarrels.add_child(first_barrel)
			
			first_barrel.destroy(zeTimber.side)
			
			timeMarker.add(self.TIME_BONUS)
			
			move_barrels_to_bottom()
			
			if check_collision():
				lose()

func generate_barrel(type, position):
	var barrel
	
	if type == self.LEFT:
		barrel = barrelTypes.left.instance()
		barrel.add_to_group(str(self.LEFT))
		self.last_enemy = true
	elif type == self.RIGHT:
		barrel = barrelTypes.right.instance()
		barrel.add_to_group(str(self.RIGHT))
		self.last_enemy = true
	else:
		barrel = barrelTypes.normal.instance()
		self.last_enemy = false
	
	barrel.set_pos(position)
	barrels.add_child(barrel)

func rand_barrel(position):
	var type = int(rand_range(0, 3))
	
	if self.last_enemy:
		type = 0
	
	generate_barrel(type, position)

func init_barrels():
	for i in range(0, 3):
		generate_barrel(0, calc_pos_ini_barrel(i))
	
	for i in range(3, 10):
		rand_barrel(calc_pos_ini_barrel(i))

func calc_pos_ini_barrel(num):
	return Vector2(self.HALF_SCREEN, self.POS_Y_INI_BARREL - (num * self.HEIGHT_BARREL))

func check_collision():
	var first_barrel = barrels.get_children()[0]
	
	# is the character on the same side of the enemy?
	if zeTimber.side == self.LEFT and first_barrel.is_in_group(str(self.LEFT)) or self.zeTimber.side == self.RIGHT and first_barrel.is_in_group(str(self.RIGHT)):
		return true
	
	return false

func move_barrels_to_bottom():
	rand_barrel(calc_pos_ini_barrel(10))
	
	for b in barrels.get_children():
		b.set_pos(b.get_pos() + Vector2(0, self.HEIGHT_BARREL))

func lose():
	self.playing = false
	zeTimber.die()
	timeMarker.set_process(false)
