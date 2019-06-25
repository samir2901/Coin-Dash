extends Area2D
export (int) var speed

signal pickup
signal hurt

var velocity = Vector2()
var screensize = Vector2(448,690)

#func _ready():
	#start(Vector2(56,56))
	#pass
	
func _process(delta):
	#for user input
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(-speed,0)
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2(speed,0)
	elif Input.is_action_pressed("ui_up"):
		velocity = Vector2(0,-speed)
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2(0,speed)
	else:
		velocity = Vector2(0,0)
	var pos = get_position() + velocity*delta
	var f_pos = Vector2()
	f_pos.x = clamp(pos.x, 0, screensize.x)
	f_pos.y = clamp(pos.y, 0, screensize.y)
	set_position(f_pos)
	
	
	
	#for animation
	if velocity.length() > 0:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.play("Idle")
	pass
	
	
func start(pos):
	$AnimatedSprite.play("Idle")
	set_position(pos)
	set_process(true)
	pass
	
func hurt():
	$AnimatedSprite.play("Hurt")
	set_process(false)
	pass

func _on_Player_area_entered(area):
	if area.is_in_group("Coins"):
		area.pickup()
		emit_signal("pickup")
	elif area.is_in_group("Obstacle"):
		emit_signal("hurt")
		hurt()
	pass 
