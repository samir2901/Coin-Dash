extends Area2D

var screensize=Vector2(430,680)

func pickup():
	queue_free()

func _on_Coin_area_entered(area):
	if area.is_in_group("Obstacle"):
		position = Vector2(rand_range(0,screensize.x),rand_range(0,screensize.y))
	pass 
