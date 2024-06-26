extends Node2D

class_name Game

static var player : Player = null
static var instance: Game = null

var suspicion_time : float = 0 # The time the player has been in the detection zone if this get bigger than some amount the player is detected
var suspicion_time_max : float = 2 # The time the player has been in the detection zone
var suspicion_decay : float = 0 # The time the player has been in the detection zone

func _exit_tree():
    instance = null
    player = null

func _ready():
    instance = self
    player = $Player
