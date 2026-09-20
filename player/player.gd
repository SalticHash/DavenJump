extends CharacterBody2D

var coins: int = 0 :
	set(v):
		coins = v
		%CoinCount.text = "Coins: " + str(coins)
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 800.0


func _physics_process(delta: float) -> void:
	$Camera.limit_bottom = min(global_position.y + 288.0, $Camera.limit_bottom)
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Feet.play("jump")
	else:
		if $Feet.animation != "fall" and velocity.y > 0:
			$Feet.play("fall")
		velocity.y += GRAVITY * delta

	velocity.x = Input.get_axis("left", "right") * SPEED

	move_and_slide()
