extends Node2D

var score: int = 0

func _ready() -> void:
    display_score()

func increment_score(delta: int) -> void:
    score += delta
    display_score()

func display_score() -> void:
    $ScoreLabel/Score.text = String(score)

func get_score() -> int:
    return score
