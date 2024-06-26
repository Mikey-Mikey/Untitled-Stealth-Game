extends CharacterBody2D

class_name Player

@export var player_speed : float = 300; # Speed in pixels per second
@export var gravity : float = 980; # Gravity in pixels per second squared

func _physics_process (delta: float):

    var movement_x = Input.get_axis("move_left", "move_right")

    # Super basic :skull:, definetly will add more depth. Dash maybe?

    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        velocity.x = movement_x * player_speed
        if Input.is_action_just_pressed("jump"):
            velocity.y = -sqrt(2 * gravity * 100)

    move_and_slide()