class_name MoveResource
extends Resource

enum Category {
	PHYSIC,
	SPECIAL,
	STATUS,
}

@export var name: StringName
@export var power: int
@export var accuracy: int
@export var max_power_points: int
@export var description: String
@export var type: TypeManager.Types
@export var category: Category
@export var effects: Array[MoveEffect]
@export var effect_chanche: int
@export var priority: int
@export var flags: Array[String]

var current_power_points: int
