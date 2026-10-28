class_name BattlePokemon
extends Object

var current_health_points: int:
	get:
		return _current_health_points
var max_health_points: int:
	get:
		return _max_health_points
var attack: int:
	get:
		return _attack
var defense: int:
	get:
		return _defense
var special_attack: int:
	get:
		return _special_attack
var special_defense: int:
	get:
		return _special_defense
var speed: int:
	get:
		return _speed
var name: String
var can_attack: bool = true
var status_condition: StatusCondition
var volatile_status_conditions: Array[StatusCondition]
var moves: Array[MoveResource]
var _current_health_points: int
var _max_health_points: int
var _attack: int
var _defense: int
var _special_attack: int
var _special_defense: int
var _speed: int


func _init(pokemon_resource: PokemonResource) -> void:
	_max_health_points = pokemon_resource.base_stats.health_points
	_current_health_points = max_health_points
	_attack = pokemon_resource.base_stats.attack
	_defense = pokemon_resource.base_stats.defense
	_special_attack = pokemon_resource.base_stats.special_attack
	_special_defense = pokemon_resource.base_stats.special_defense
	_speed = pokemon_resource.base_stats.speed
	name = pokemon_resource.info.name
	moves.assign(pokemon_resource.learnset)


func apply_damage(amount: int) -> void:
	amount = max(amount, 0)
	_current_health_points = max(_current_health_points - amount, 0)


func get_all_current_status_conditions() -> Array[StatusCondition]:
	var status_conditions: Array[StatusCondition]
	if status_condition:
		status_conditions.append(status_condition)
	status_conditions.append_array(volatile_status_conditions)
	return status_conditions
