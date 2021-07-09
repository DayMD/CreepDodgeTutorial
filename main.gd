extends Node

export (PackedScene) var Mob
var score


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$Music.stop()
	$Fail.play()
	$ScoreTimer.stop()
	$enemyTimer.stop()
	get_tree().call_group("enemy", "queue_free")
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	$StartTimer.start()

func _on_enemyTimer_timeout():
	$enemyPath/enemySpawnLocation.offset = randi()
	var enemy = Mob.instance()
	add_child(enemy)
	var direction = $enemyPath/enemySpawnLocation.rotation + PI / 2
	enemy.position = $enemyPath/enemySpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$enemyTimer.start()
	$ScoreTimer.start()
