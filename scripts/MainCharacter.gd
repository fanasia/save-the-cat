extends KinematicBody2D

signal catplaced

var screen_size
var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()

var picked = false
var cat

func _ready():
	screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		$AnimatedSprite.play("GoTop")
		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		$AnimatedSprite.play("GoDown")
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		$AnimatedSprite.play("GoLeft")
		
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		$AnimatedSprite.play("GoRight")
	
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 200)

func _physics_process(delta):
	read_input()
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)   
	
	if Input.is_action_just_pressed("pick_up"):
		if not picked:
			for body in $CatDetection.get_overlapping_bodies():
				if body.is_in_group("cat"):
					picked = true
					body.queue_free()
		else:
			picked = false
			var cat = preload("res://scenes/Cat.tscn").instance()
			var min_speed = cat.min_speed
			var max_speed = cat.max_speed
			cat.global_position = $CatPosition.global_position
			get_tree().get_current_scene().add_child(cat)
			# emit_signal("catplaced")
			
			# check if it's in safe zone, idle before go / just go directly
			for body in $CatDetection.get_overlapping_areas():
				if body.is_in_group("safe_zone"):
					# wait for timeout
					yield(get_tree().create_timer(4), "timeout")
			
			var direction = rand_range(0, 360)
			if (cat and weakref(cat).get_ref()):
				cat.set_linear_velocity(Vector2(rand_range(min_speed, max_speed), 0).rotated(direction))
