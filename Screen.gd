extends Node2D

func _ready() -> void:
    var screen_size = get_viewport_rect().size

    $Background.set_position(Vector2(0, 0))
    $Background.set_size(screen_size)

    $Lobster.position.x = screen_size.x / 2
    $Lobster.position.y = screen_size.y / 2

    $StarvationTimer.connect("timeout", self, "_on_StarvationTimer_timeout")

func _on_StarvationTimer_timeout():
    $Stats.increment_score(-1)
