extends CharacterBody2D

var coins: int = 0 :
	set(v):
		coins = v
		$CollectSound.play()
		%CoinCount.text = "Coins: " + str(coins)
const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
const GRAVITY = 2000.0

func _ready() -> void:
	if OS.get_name() == "Android" or OS.get_name() == "iOS": 
		%Controls.show()
var lost: bool = false
func _physics_process(delta: float) -> void:
	if lost: return
	if global_position.x < -42.0:
		global_position.x = 366.0
	if global_position.x > 366.0:
		global_position.x = -42.0
	$Camera.limit_bottom = min(global_position.y + 288.0, $Camera.limit_bottom)
	if global_position.y - 37.0 > $Camera.limit_bottom:
		lost = true
		%Lost.show()
		if Global.last_coins == -1 or Global.last_coins == coins: %HighScore.hide()
		%HighScore.text = "New high score!" if coins > Global.last_coins \
			else "High score: " + str(Global.last_coins)
		Global.last_coins = coins
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Feet.play("jump")
		$Land.play()
	else:
		if $Feet.animation != "fall" and velocity.y > 0:
			$Feet.play("fall")
		velocity.y += GRAVITY * delta
	
	var dir = Input.get_axis("left", "right")
	if %Controls.visible:
		dir = -1 if %Left.button_pressed else 1 if %Right.button_pressed else 0
	velocity.x = dir * SPEED

	move_and_slide()

func bounce() -> void:
	velocity.y = -3000
	$BounceSound.play()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
