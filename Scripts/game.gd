extends Node2D

class_name Game

static var player : Player = null
static var instance: Game = null

func _exit_tree():
    instance = null
    player = null

func _ready():
    instance = self
    player = $Player
