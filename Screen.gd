extends Node2D

export (PackedScene) var Pill
var screen_size: Vector2

func _ready() -> void:
    randomize()

    screen_size = get_viewport_rect().size

    $Background.set_position(Vector2(0, 0))
    $Background.set_size(screen_size)

    $Lobster.position.x = screen_size.x / 2
    $Lobster.position.y = screen_size.y / 2

    $PillSpawnTimer.connect("timeout", self, "_on_PillSpawnTimer_timeout")
    $StarvationTimer.connect("timeout", self, "_on_StarvationTimer_timeout")

func _on_PillSpawnTimer_timeout() -> void:
    var pill = Pill.instance()
    pill.position = Vector2(
        rand_range(0, screen_size.x),
        rand_range(0, screen_size.y)
    )
    pill.visible = true
    add_child(pill)

func _on_StarvationTimer_timeout() -> void:
    $Stats.increment_score(-1)
