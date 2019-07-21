extends KinematicBody2D

onready var player_scene = preload("res://Player/playercharacter.tscn")
var velocity = Vector2()
var speed = 400

func _ready():
    var player = player_scene.instance()
    add_child(player)

func _process(delta):
    if $player.position.x < position.x:
        velocity.x -= speed

func _physics_process(delta):
    velocity = move_and_slide(velocity * delta)