extends Area2D

# How much it's worth; customizable
export var value: int = 666

func _enter_tree() -> void:
    $AnimationPlayer.play("jiggle")
