@tool
class_name PokemonBaseStatsResource
extends Resource

const MAX_STATS := 600

@export var unnused_points: int

@export_range(1, MAX_STATS, 1) var health_points: int:
	set(value):
		if would_max_stats_exedded(0, value):
			push_error("The max stat limit has been exedded")
			return
		health_points = value if value >= 1 else 1
		notify_property_list_changed()
@export_range(1, MAX_STATS, 1) var attack: int:
	set(value):
		if would_max_stats_exedded(2, value):
			push_error("The max stat limit has been exedded")
			return
		attack = value if value >= 1 else 1
		notify_property_list_changed()
@export_range(1, MAX_STATS, 1) var defense: int:
	set(value):
		if would_max_stats_exedded(3, value):
			push_error("The max stat limit has been exedded")
			return
		defense = value if value >= 1 else 1
		notify_property_list_changed()
@export_range(1, MAX_STATS, 1) var special_attack: int:
	set(value):
		if would_max_stats_exedded(4, value):
			push_error("The max stat limit has been exedded")
			return
		special_attack = value if value >= 1 else 1
		notify_property_list_changed()
@export_range(1, MAX_STATS, 1) var special_defense: int:
	set(value):
		if would_max_stats_exedded(5, value):
			push_error("The max stat limit has been exedded")
			return
		special_defense = value if value >= 1 else 1
		notify_property_list_changed()
@export_range(1, MAX_STATS, 1) var speed: int:
	set(value):
		if would_max_stats_exedded(6, value):
			push_error("The max stat limit has been exedded")
			return
		speed = value if value >= 1 else 1
		notify_property_list_changed()


func _validate_property(property: Dictionary) -> void:
	if property.name == "unnused_points":
		property.usage |= PROPERTY_USAGE_READ_ONLY


func would_max_stats_exedded(index: int, value: int) -> bool:
	var stats: Array[int] = [
		health_points,
		attack,
		defense,
		special_attack,
		special_defense,
		speed,
	]
	stats[index] = value
	var sum := func(accum: int, number: int) -> int:
		return accum + number
	unnused_points = MAX_STATS - stats.reduce(sum)
	return stats.reduce(sum) > MAX_STATS
