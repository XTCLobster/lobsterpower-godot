extends Node2D

export(PackedScene) var Pill
onready var screen_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
    randomize()

    $Background.set_position(Vector2(0, 0))
    $Background.set_size(screen_size)

    $Lobster.position.x = screen_size.x / 2
    $Lobster.position.y = screen_size.y / 2
    $Lobster.connect("consume", self, "_on_Lobster_consume")

    $PillSpawnTimer.connect("timeout", self, "_on_PillSpawnTimer_timeout")
    $StarvationTimer.connect("timeout", self, "_on_StarvationTimer_timeout")

func _on_Lobster_consume(area: Area2D) -> void:
    var value: int = area.get("value")
    remove_child(area)
    $Stats.increment_score(value)
    $Lobster.speed = $Lobster.base_speed * ($Stats.get_score() / 1000 + 1)
    $Lobster/AnimationPlayer.play("eat")

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
