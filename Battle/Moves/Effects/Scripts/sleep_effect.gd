class_name SleepEffect
extends MoveEffect

func apply(turn: Turn, _battle_system: BattleSystem) -> void:
	turn.target.status_condition = SleepCondition.new()
