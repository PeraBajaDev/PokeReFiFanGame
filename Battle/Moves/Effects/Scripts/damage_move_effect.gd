class_name DamageMoveEffect
extends MoveEffect


func apply(turn: Turn, _battle_system: BattleSystem) -> void:
	var amount: int
	var pokemon_target: BattlePokemon = turn.target
	var pokemon_user: BattlePokemon = turn.attacker
	var move: MoveResource = turn.move
	if not pokemon_user.can_attack:
		print(pokemon_user.name, " can't attack!")
		return
	# if pokemon_user.current_power_points <= 0:
	# 	print(pokemon_user.name, " has no power points!")
	# 	return
	match move.category:
		move.Category.PHYSIC:
			amount = (pokemon_user.attack / float(pokemon_target.defense)) * move.power
		move.Category.SPECIAL:
			amount = (pokemon_user.special_attack / float(pokemon_target.special_defense)) * move.power
	pokemon_target.apply_damage(amount)
	print("Doing damage: ", amount, " from: ", pokemon_user.name, " to: ", pokemon_target.name)
