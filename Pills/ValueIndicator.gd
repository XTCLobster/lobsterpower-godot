extends Node2D

var value: int setget set_value

func _enter_tree() -> void:
    animate_decay()

func animate_decay() -> void:
    $AnimationPlayer.play("decay")

    # Removes itself when finished animating
    yield($AnimationPlayer, "animation_finished")
    queue_free()

func set_value(new_value: int) -> void:
    $Label.text = "%d" % [new_value]
