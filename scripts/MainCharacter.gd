extends KinematicBody2D

signal catplaced

var screen_size
var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()

var picked = false
var cat
var is_walking = false
var player_animation

enum ANIMATION {
	WALKDOWN,
	WALKUP,
	WALKLEFT,
	WALKRIGHT
}

func _ready():
	screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func read_input():
	velocity = Vector2()
	
	if picked:
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			$AnimatedSprite.play("GoTop_Cat")
			player_animation = ANIMATION.WALKUP
		if Input.is_action_pressed("down"):
			velocity.y += 1
			$AnimatedSprite.play("GoDown_Cat")
			player_animation = ANIMATION.WALKDOWN
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("GoLeft_Cat")
			player_animation = ANIMATION.WALKLEFT
		if Input.is_action_pressed("right"):
			velocity.x += 1
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("GoLeft_Cat")
			player_animation = ANIMATION.WALKRIGHT
	else:
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			$AnimatedSprite.play("GoTop")
			player_animation = ANIMATION.WALKUP
		if Input.is_action_pressed("down"):
			velocity.y += 1
			$AnimatedSprite.play("GoDown")
			player_animation = ANIMATION.WALKDOWN
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("GoLeft")
			player_animation = ANIMATION.WALKLEFT
		if Input.is_action_pressed("right"):
			velocity.x += 1
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("GoLeft")
			player_animation = ANIMATION.WALKRIGHT
	
	if player_animation == ANIMATION.WALKUP and velocity == Vector2.ZERO:
		if picked:
			$AnimatedSprite.play("IdleTop_Cat")
		else:
			$AnimatedSprite.play("IdleTop")
	if player_animation == ANIMATION.WALKDOWN and velocity == Vector2.ZERO:
		if picked:
			$AnimatedSprite.play("IdleDown_Cat")
		else:
			$AnimatedSprite.play("IdleDown")
	if player_animation == ANIMATION.WALKLEFT and velocity == Vector2.ZERO:
		$AnimatedSprite.flip_h = false
		if picked:
			$AnimatedSprite.play("IdleLeft_Cat")
		else:
			$AnimatedSprite.play("IdleLeft")
	if player_animation == ANIMATION.WALKRIGHT and velocity == Vector2.ZERO:
		$AnimatedSprite.flip_h = true
		if picked:
			$AnimatedSprite.play("IdleLeft_Cat")
		else:
			$AnimatedSprite.play("IdleLeft")
	
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
					$PickUpEffect.play()
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
