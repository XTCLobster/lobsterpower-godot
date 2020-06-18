extends Node2D

var Pill1: PackedScene = load("res://Pills/Pill1.tscn")
var Pill2: PackedScene = load("res://Pills/Pill2.tscn")
var Pill3: PackedScene = load("res://Pills/Pill3.tscn")
var Pill4: PackedScene = load("res://Pills/Pill4.tscn")
var Pill5: PackedScene = load("res://Pills/Pill5.tscn")
var Pill6: PackedScene = load("res://Pills/Pill6.tscn")
var ValueIndicator: PackedScene = load("res://Pills/ValueIndicator.tscn")

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

func _on_pill_consumed(pill: BasePill) -> void:
    increment_score(pill.value)
    show_value_for_pill(pill)
    $Lobster/AnimationPlayer.play("eat")
    $Lobster/CollectAudioStreamPlayer.play()

func show_value_for_pill(pill: BasePill) -> void:
    var value_indicator: Node2D = ValueIndicator.instance()
    value_indicator.value = pill.value
    value_indicator.position = Vector2(
        max(0, $Lobster.position.x),
        max(0, $Lobster.position.y - 50)
    )
    add_child(value_indicator)

func _on_PillSpawnTimer_timeout() -> void:
    var num_pills: int = randi() % 3 + 1 # 1...3
    for i in num_pills:
        spawn_pill()

func spawn_pill() -> void:
    var pill: Node = random_pill_node()
    pill.position = Vector2(
        rand_range(0, screen_size.x),
        rand_range(0, screen_size.y)
    )
    pill.visible = true
    add_child(pill)

func random_pill_node() -> Node:
    var pill_variant = randi() % 6
    match pill_variant:
        0: return Pill1.instance()
        1: return Pill2.instance()
        2: return Pill3.instance()
        3: return Pill4.instance()
        4: return Pill5.instance()
        5: return Pill6.instance()
        _: return Pill1.instance()

func _on_StarvationTimer_timeout() -> void:
    # Decrease by (0.01% ... 1%)
    increment_score(-$Stats.get_score() * rand_range(0.0001, 0.01))

func increment_score(value: int) -> void:
    $Stats.increment_score(value)
    adjust_lobster_speed()

func adjust_lobster_speed() -> void:
    # Move at the speed of a 1/1000th of the score, but at 1.0x at least
    var speed_factor: float = max(1.0, float($Stats.get_score()) / 1000)
    $Lobster.speed = $Lobster.base_speed * speed_factor
