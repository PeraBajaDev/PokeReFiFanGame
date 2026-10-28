class_name ParalisisCondition
extends StatusCondition

func _init() -> void:
	turns_left = 3


func on_before_move(turn: Turn) -> void:
	if turns_left == 3:
		turn.attacker.can_attack = false
