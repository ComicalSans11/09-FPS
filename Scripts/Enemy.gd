extends KinematicBody

var health : int = 4
var moveSpeed : float = 1.0
var damage : int = 1
var attackRate : float = 1.0
var attackDist : float = 2.0
var scoreToGive : int = 10

onready var player : Node = get_node("/root/MainScene/Player")
onready var timer : Timer = get_node("Timer")

func _ready ():
	timer.set_wait_time(attackRate)
	timer.start()

func _on_Timer_timeout():
	if translation.distance_to(player.translation) <= attackDist:
		attack()

func _physics_process(_Delta):
	var dir = (player.translation - translation).normalized()
	dir.y = 0
	move_and_slide(dir * moveSpeed, Vector3.UP)

func take_damage (damage):
	health -= damage
	if health <= 0:
		die()

func die():
	player.add_score(scoreToGive)
	queue_free()

func attack():
	player.take_damage(damage)
	
