class_name CharacterSprite
extends AnimatedSprite3D


func do_walk(walking_direction: Vector2i) -> void:
	if walking_direction == Vector2i.UP:
		play("WALK_UP")
	elif walking_direction == Vector2i.DOWN:
		play("WALK_DOWN")
	elif walking_direction == Vector2i.LEFT:
		play("WALK_LEFT")
		flip_h = true
	elif walking_direction == Vector2i.RIGHT:
		play("WALK_RIGHT")
		flip_h = false
	else:
		stop()
