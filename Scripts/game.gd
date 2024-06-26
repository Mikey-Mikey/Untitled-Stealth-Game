extends Node2D

class_name Game

static var player : Player = null
static var instance: Game = null

signal game_over()

var suspicion_time : float = 0 # The time the player has been in the detection zone if this get bigger than some amount the player is detected
var suspicion_time_max : float = 2 # The time the player has been in the detection zone
var suspicion_decay : float = 0 # The time the player has been in the detection zone

func _exit_tree():
    instance = null
    player = null

func _ready():
    Game.instance = self
    Game.player = $Player
    

func _process(delta):
    
    suspicion_time -= suspicion_decay * delta
    if suspicion_time < 0:
        suspicion_time = 0

    if suspicion_time > suspicion_time_max:
        emit_signal("game_over")
        _game_over()

func _game_over():

    print("Game Over")