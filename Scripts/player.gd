extends CharacterBody2D

class_name Player

@export var player_speed : float = 300 # Speed in pixels per second
@export var gravity : float = 1200 # Gravity in pixels per second squared
@export var player_sprite : AnimatedSprite2D = null

func _physics_process (delta: float):

    var movement_x = Input.get_axis("move_left", "move_right")
    if movement_x != 0:
        player_sprite.play("run")
        player_sprite.speed_scale = abs(velocity.x * 0.006)
        player_sprite.flip_h = movement_x > 0
    elif is_on_floor():
        player_sprite.play("idle")

    # Super basic :skull:, definetly will add more depth. Dash maybe?

    if not is_on_floor():
        player_sprite.play("jump")
        velocity.y += gravity * delta
        velocity.x += movement_x * player_speed * delta
    else:
        velocity.x += (movement_x * player_speed - velocity.x) * 0.1
        if Input.is_action_just_pressed("jump"):
            velocity.y = -sqrt(2 * gravity * 100)

    move_and_slide()