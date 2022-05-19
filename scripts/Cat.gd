extends RigidBody2D

export (int) var min_speed # Minimum speed range.
export (int) var max_speed # Maximum speed range.

var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size
	
#	var playernode = get_tree().get_root().find_node("Player", true, false)
#	playernode.connect("catplaced", self, "handlecatplaced")

# make portal screen
func _integrate_forces(state):
	var xform = state.get_transform()
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	state.set_transform(xform)
	# wanna make it turn back when reach edge of the screen
	
	if linear_velocity == Vector2.ZERO:
		$AnimatedSprite.play("Idle")
	else:
		if rotation == -PI/2:
			$AnimatedSprite.play("GoUp")
		if rotation == PI/2:
			$AnimatedSprite.play("GoDown")
		if (rotation <= 0 and rotation > -(PI/2)) or (rotation >= 0 and rotation < PI/2): #right
#			print("I'm going right", rotation)
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("GoLeft")
		if (rotation <= -(PI/2) and rotation > -(PI) or (rotation >= PI/2 and rotation <= PI)): #left
#			print("I'm going left", rotation)
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("GoLeft")

#func handlecatplaced():
	# wait for timeout
#	yield(get_tree().create_timer(3), "timeout")
	
	# go into another direction again
#	var direction = rand_range(0, 360)
#	self.set_linear_velocity(Vector2(rand_range(self.min_speed, self.max_speed), 0).rotated(direction))
