@abstract
class_name StatusCondition

var turns_left := INF


func on_turn_start(pokemon_user: BattlePokemon, pokemon_foe: BattlePokemon) -> void:
	pass


func on_before_move(_turn: Turn) -> void:
	pass


func on_after_move(_turn: Turn) -> void:
	pass


func on_turn_end() -> void:
	pass
