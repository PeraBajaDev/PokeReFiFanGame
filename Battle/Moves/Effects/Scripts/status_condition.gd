@abstract
class_name StatusCondition

var turns_left := INF


func on_turn_start(pokemon_user, pokemon_foe) -> void:
	pass


func on_before_move(_turn: Turn) -> void:
	pass


func on_after_move(_turn: Turn) -> void:
	pass


func on_turn_end() -> void:
	pass
