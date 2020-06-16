extends Area2D

export var base_speed: float = 200
var speed: float = base_speed
onready var screen_size: Vector2 = get_viewport_rect().size

signal consume

func _process(delta: float) -> void:
    var velocity = velocity()
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)

func velocity() -> Vector2:
    # Compute the movement vector based on input
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1

    # Apply player speed in input direction
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed

    return velocity

func _on_Lobster_area_entered(area: Area2D) -> void:
    emit_signal("consume", area)
