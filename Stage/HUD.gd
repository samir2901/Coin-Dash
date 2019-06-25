extends CanvasLayer

signal start_game


func update_score(value):
	$MarginContainer/Score.text = str(value)
	pass
	
func update_time(value):
	$MarginContainer/Time.text = str(value)
	
func show_message(text):
	$GameLabel.text = text
	$GameLabel.show()
	$MarginContainer/Time/MessageTimer.start()
	
	
func show_gameover():
	show_message("Game Over!")
	yield($MarginContainer/Time/MessageTimer, "timeout")
	$StartButton.show()
	$GameLabel.text = "Coin Dash!"
	$GameLabel.show()
	pass

func _on_MessageTimer_timeout():
	$GameLabel.hide()
	pass 

func _on_StartButton_pressed():
	$StartButton.hide()
	$GameLabel.hide()
	emit_signal("start_game")
	pass
