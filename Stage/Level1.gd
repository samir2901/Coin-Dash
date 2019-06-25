extends Node

export (PackedScene) var coin
export (int) var playtime

const Coin = preload("res://Scenes/Coin.tscn")

var level
var score
var timeleft
var screensize
var playing = false


func _ready():
	randomize()
	screensize = Vector2(430,680)
	$Player.screensize = screensize
	$Player.hide()
	pass
	
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		timeleft += 5
		$LevelUp.play()
		spawn_coin()
	pass
	

func newgame():
	level = 1
	score = 0
	timeleft = playtime
	playing = true
	$Player.start($PlayerStartPos.position)
	$Player.show()
	$GameTimer.start()
	$HUD.update_score(score)
	$HUD.update_time(timeleft)
	spawn_coin()
	pass

func spawn_coin():
	for i in range(4+level):
		var coin_scn = Coin.instance()
		get_node("CoinContainer").add_child(coin_scn)
		coin_scn.position = Vector2(rand_range(0,400),rand_range(0,600))
	pass
	



func _on_GameTimer_timeout():
	timeleft -= 1
	$HUD.update_time(timeleft)
	if timeleft <= 0:
		game_over()
	pass 
	


func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
	$CoinPickUp.play()
	pass # Replace with function body.


func _on_Player_hurt():
	game_over()
	
	pass # Replace with function body.
	
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_gameover()
	$GameOver.play()
	$Player.hurt()
	pass


func _on_Cactus1_area_entered(area):
	if area.is_in_group("Obstacle"):
		pass
	pass 
