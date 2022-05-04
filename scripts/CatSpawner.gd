extends Timer

# you can add more cats here
var cat1 = preload("res://scenes/Cat.tscn")

func _on_Timer_timeout():
	randomize()
	var cats = [cat1] # you can add more here
	var kinds = cats[randi()% cats.size()]
	var chosen_cat = kinds.instance()
	chosen_cat.position = Vector2(rand_range(10,990), rand_range(10,590))
	add_child(chosen_cat)
	
	# choose direction and making it move
	var direction = rand_range(0, 360)
	chosen_cat.rotation = direction
	chosen_cat.set_linear_velocity(Vector2(rand_range(chosen_cat.min_speed, chosen_cat.max_speed), 0).rotated(direction))
