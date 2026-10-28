class_name SleepCondition
extends StatusCondition

func _init() -> void:
	turns_left = 3


func on_before_move(turn: Turn) -> void:
	turn.attacker.can_attack = false
