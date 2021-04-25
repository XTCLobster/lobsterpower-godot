extends KinematicBody2D

export var base_speed: float = 200
var speed: float = base_speed
var velocity: Vector2 = Vector2()
onready var screen_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
    add_inputs()

var controls = {"move_right": [KEY_RIGHT, KEY_D, KEY_L],
                "move_left": [KEY_LEFT, KEY_A, KEY_H],
                "move_up": [KEY_UP, KEY_W, KEY_K],
                "move_down": [KEY_DOWN, KEY_S, KEY_J]}

func add_inputs():
    var ev
    for action in controls:
        if not InputMap.has_action(action):
            InputMap.add_action(action)
        for key in controls[action]:
            ev = InputEventKey.new()
            ev.scancode = key
            InputMap.action_add_event(action, ev)

func _physics_process(delta: float) -> void:
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        move_and_collide(velocity * delta)

func _process(delta: float) -> void:
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)

func _input(event: InputEvent) -> void:
    self.velocity = Vector2()
    if Input.is_action_pressed("move_right"):
        self.velocity.x = 1
    if Input.is_action_pressed("move_left"):
        self.velocity.x = -1
    if Input.is_action_pressed("move_down"):
        self.velocity.y = 1
    if Input.is_action_pressed("move_up"):
        self.velocity.y = -1
