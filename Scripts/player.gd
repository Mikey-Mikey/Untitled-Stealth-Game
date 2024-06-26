extends CharacterBody2D

@export var player_speed : float = 100; # Speed in pixels per second

func _physics_process (delta: float):

    var movement_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

    # Super basic :skull:, definetly will add more depth. Dash maybe?

    velocity = movement_vector * player_speed
    move_and_slide()