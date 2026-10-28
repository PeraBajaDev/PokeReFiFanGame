class_name Turn

var target: BattlePokemon
var attacker: BattlePokemon
var move: MoveResource


func _init(_target: BattlePokemon, _attacker: BattlePokemon, _move: MoveResource) -> void:
	self.target = _target
	self.attacker = _attacker
	self.move = _move
