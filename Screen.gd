extends Node2D

export(PackedScene) var Pill: PackedScene
onready var screen_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
    randomize()

    $Background.set_position(Vector2(0, 0))
    $Background.set_size(screen_size)

    $Lobster.position.x = screen_size.x / 2
    $Lobster.position.y = screen_size.y / 2
    Events.connect("pill_consumed", self, "_on_pill_consumed")

    $PillSpawnTimer.connect("timeout", self, "_on_PillSpawnTimer_timeout")
    $StarvationTimer.connect("timeout", self, "_on_StarvationTimer_timeout")

func _on_pill_consumed(value: int) -> void:
    $Stats.increment_score(value)
    $Lobster.speed = $Lobster.base_speed * ($Stats.get_score() / 1000 + 1)
    $Lobster/AnimationPlayer.play("eat")
    $Lobster/CollectAudioStreamPlayer.play()

func _on_PillSpawnTimer_timeout() -> void:
    var num_pills: int = randi() % 3 + 1 # 1...3
    for i in num_pills:
        spawn_pill()

func spawn_pill() -> void:
    var pill: Node2D = Pill.instance()
    pill.position = Vector2(
        rand_range(0, screen_size.x),
        rand_range(0, screen_size.y)
    )
    pill.visible = true
    add_child(pill)

func _on_StarvationTimer_timeout() -> void:
    $Stats.increment_score(-1)
