extends CharacterBody3D

@export var tile_size: float
@export var move_speed: float

var is_moving: bool = false

@onready var ray_cast: RayCast3D = $RayCast3D
@onready var sprite: CharacterSprite = $AnimatedSprite3D


func _process(_delta: float) -> void:
	if is_moving:
		return

	var input_dir := Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN

	if input_dir != Vector2.ZERO:
		var move_dir := Vector3(input_dir.x, 0, input_dir.y)
		sprite.do_walk(input_dir)
		move(move_dir)


func move(move_dir: Vector3) -> void:
	ray_cast.target_position = move_dir * tile_size
	ray_cast.force_raycast_update()

	if ray_cast.is_colliding():
		return

	is_moving = true
	var target_position: Vector3 = position + (move_dir * tile_size)

	var tween := create_tween()
	tween.tween_property(self, "position", target_position, 1.0 / move_speed).set_trans(
		Tween.TRANS_LINEAR
	)
	tween.finished.connect(
		func() -> void:
			is_moving = false
			sprite.stop(),
	)
