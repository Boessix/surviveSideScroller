extends CharacterBody2D

@export var speed = 800

var flipped = false
var isDodging = false
var isJumping = false

func _process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
	
	if(Input.is_action_pressed("move_left") && !isDodging && !isJumping):
		if(!flipped):
			flipped = true
			$CharacterSprite.set_flip_h(true)
		playerRunning()
	elif(Input.is_action_pressed("move_right") && !isDodging && !isJumping):
		if(flipped):
			flipped = false
			$CharacterSprite.set_flip_h(false)
		playerRunning()
	else:
		if(!isDodging && !isJumping):
			playerIdle()
		
	if(Input.is_action_pressed("dodge_roll") && !isJumping):
		isDodging = true
		playerRoll()
		
	if(Input.is_action_pressed("jump")):
		isJumping = true
		playerJump()

func playerRunning():
	$CharacterSprite.play("running")

func playerIdle():
	$CharacterSprite.play("idle")

func playerRoll():
	$CharacterSprite.play("roll")

func playerJump():
	$CharacterSprite.play("jump")


func _on_character_sprite_animation_finished():
	if($CharacterSprite.animation == "roll"):
		isDodging = false
	if($CharacterSprite.animation == "jump"):
		if(isDodging):
			isDodging= false
		isJumping = false
