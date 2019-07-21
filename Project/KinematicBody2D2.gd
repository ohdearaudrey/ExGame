extends KinematicBody2D

onready var player = get_node("res://Player/playercharacter.tscn")
var velocity = Vector2()
var speed = 5000




func _physics_process(delta):
    velocity = move_and_slide(velocity * delta)