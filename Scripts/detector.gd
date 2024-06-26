@tool
extends Node2D

class_name Detector # This is the base class for all things that can catch the player

@onready var player: Player = Game.player

signal player_detected(delta: float)

var player_in_view: bool = false
@export var fov: float = 90 # Field of view in degrees
@export var detection_distance: float = 100 # Distance in pixels

func _process(delta):

	if Engine.is_editor_hint():
		queue_redraw()
		return

	detect_player(delta)
	queue_redraw()

func fov_rad() -> float:
	return deg_to_rad(fov)

func detect_player(delta):
	player = Game.player
	var player_position = player.global_position
	var detector_position = global_position
	var player_direction = player_position - detector_position
	var distance_to_player = player_direction.length()
	var current_view_direction = transform.x.normalized()
	player_direction = player_direction.normalized()

	var angle_to_player = current_view_direction.angle_to(player_direction)
	if angle_to_player < fov_rad() / 2 and distance_to_player < detection_distance:

		# WE do raycast
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player_position)
		query.exclude = [self.get_parent()]
		query.collision_mask = 0b11
		var result = space_state.intersect_ray(query)


		if result:
			print(result)
			if result.collider == player:
				print("Player Detected")
				_player_detected(delta)
				emit_signal("player_detected", delta)
				player_in_view = true
	else:
		player_in_view = false

func _player_detected(delta):
	# We add to the suspicon variable in the game script
	Game.instance.suspicion_time += delta

func _draw():
	for i in range(0, 4):

		draw_arc(
			Vector2(0, 0),
			detection_distance * (i / 4.0),
			-fov_rad() / 2,
			fov_rad() / 2,
			16,
			Color(1, 0, 0, 1.0)
		)

		
	
