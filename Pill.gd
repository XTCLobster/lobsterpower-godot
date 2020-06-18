extends Area2D

# How much it's worth; customizable
export var value: int = 666

func _enter_tree() -> void:
    $AnimationPlayer.play("jiggle")

func _on_Pill_body_entered(body: Node) -> void:
    Events.emit_signal("pill_consumed", self.value)
    self.queue_free()
