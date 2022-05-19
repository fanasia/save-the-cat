extends KinematicBody2D

var _cat = null
var screen_size
var current_position
var chased = false

const CHASE_SPEED=180
const NORMAL_SPEED=3

onready var safezone = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if _cat:
		# chase cat
		var cat_direction = (_cat.position - self.position).normalized()
		
		$AnimatedSprite.flip_h = cat_direction.x > 0
		$AnimatedSprite.play("FlyLeft")
		
		move_and_slide(CHASE_SPEED * cat_direction)
	elif chased:
		# after picking up cat, go outside screen
		position = self.position
		
		var x_destination = 0
		var y_destination = 0
		var speed = NORMAL_SPEED
		
		# move and slide outside of screen
		if position.x <= (screen_size.x / 2):
			x_destination = 0 - 25
		else:
			x_destination = screen_size.x + 25
			speed = 0.1
			
		if position.y <= (screen_size.y / 2):
			y_destination = 0 - 25
		else:
			y_destination = screen_size.y + 25
			speed = 0.1
		
		$AnimatedSprite.flip_h = x_destination > 0
		$AnimatedSprite.play("FlyLeft_Cat")
		
		var position = Vector2(x_destination, y_destination)
		move_and_slide(speed * position)
	else:
		# wandering go to a position
		position = self.position
		#print("current position", position)
		
		var x_destination = 0
		var y_destination = 0
		var speed = NORMAL_SPEED
		
		# choose random position in screen
		if position.x <= (screen_size.x / 2):
			x_destination = rand_range(screen_size.x/2, screen_size.x)
		else:
			x_destination = rand_range(0, screen_size.x/2)
			speed = 0.1
			
		if position.y <= (screen_size.y / 2):
			y_destination = rand_range(screen_size.y/2, screen_size.y)
		else:
			y_destination = rand_range(0, screen_size.y/2)
			speed = 0.1
		
		$AnimatedSprite.flip_h = x_destination > 0
		$AnimatedSprite.play("FlyLeft")
		
		var position = Vector2(x_destination, y_destination)
		move_and_slide(speed * position)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_CatChaseDetectionZone_body_entered(body):
	if body.is_in_group("cat") and not safezone:
		_cat = body

func _on_CatChaseDetectionZone_body_exited(body):
	if body.is_in_group("cat"):
		_cat = null

func _on_CatGetDetection_body_entered(body):
	# for not pick cat in safezone
	if body.is_in_group("cat") and not safezone:
		body.queue_free()
		chased = true

func _on_CatGetDetection_area_entered(area):
	if area.is_in_group("safe_zone"):
		safezone = true

func _on_CatGetDetection_area_exited(area):
	if area.is_in_group("safe_zone"):
		safezone = false
