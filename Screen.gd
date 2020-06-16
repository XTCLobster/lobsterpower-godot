extends Node2D

onready var lobster: Area2D = $Lobster
var screen_size: Vector2

func _ready() -> void:
    screen_size = get_viewport_rect().size

    $Background.set_position(Vector2(0, 0))
    $Background.set_size(screen_size)

    lobster.position.x = screen_size.x / 2
    lobster.position.y = screen_size.y / 2
