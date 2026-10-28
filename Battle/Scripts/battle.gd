class_name BattleSystem
extends Node

@export var move_buttons: MoveButtons
@export var pokemon_foe_resource: PokemonResource
@export var pokemon_user_resource: PokemonResource

@onready var pokemon_foe: BattlePokemon = BattlePokemon.new(pokemon_foe_resource)
@onready var pokemon_user: BattlePokemon = BattlePokemon.new(pokemon_user_resource)


func _ready() -> void:
	move_buttons.player_move_selected.connect(resolve_turn)
	await get_tree().create_timer(0.2).timeout
	move_buttons.set_buttons_texts(pokemon_user.moves)


func resolve_turn(move_name: String) -> void:
	var by_name := func(move: MoveResource) -> bool:
		return move.name == move_name
	var user_move: MoveResource = pokemon_user.moves.filter(by_name).front()
	var foe_move: MoveResource = pokemon_foe.moves.pick_random()

	var turn_order: Array[Turn] = []
	turn_order.assign(
		[
			Turn.new(pokemon_user, pokemon_foe, foe_move),
			Turn.new(pokemon_foe, pokemon_user, user_move),
		],
	)
	var by_priority_then_speed := func(a: Turn, b: Turn) -> bool:
		if a.move.priority == b.move.priority and a.attacker.speed == b.attacker.speed:
			return [true, false].pick_random()
		if a.move.priority == b.move.priority:
			return a.attacker.speed < b.attacker.speed

		return a.move.priority < b.move.priority

	turn_order.sort_custom(by_priority_then_speed)
	print_info()
	for turn: Turn in turn_order:
		var attacker: BattlePokemon = turn.attacker
		var move: MoveResource = turn.move
		var attacker_status_conditions := attacker.get_all_current_status_conditions()
		for status: StatusCondition in attacker_status_conditions:
			status.on_before_move(turn)
		for effect: MoveEffect in move.effects:
			effect.apply(turn)
		for status: StatusCondition in attacker_status_conditions:
			status.on_after_move(turn)

	print("after turn:")
	print_info()


func print_info() -> void:
	print(
		"health user",
		pokemon_user.name,
		" : ",
		pokemon_user.current_health_points,
		"\t health foe",
		pokemon_foe.name,
		" : ",
		pokemon_foe.current_health_points,
	)
