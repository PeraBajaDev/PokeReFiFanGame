class_name SleepEffect
extends MoveEffect


func apply(turn: Turn) -> void:
	turn.target.status_condition = SleepCondition.new()
