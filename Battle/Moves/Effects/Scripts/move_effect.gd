class_name MoveEffect
extends Resource

func apply(_turn: Turn, _battle_system: BattleSystem) -> void:
	push_error("Trying to call from base class")
