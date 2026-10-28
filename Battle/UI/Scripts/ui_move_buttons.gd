class_name MoveButtons
extends Control

signal player_move_selected(move: String)
var move_buttons: Array[Button]


func _ready() -> void:
	move_buttons.assign(get_children())
	for button in move_buttons:
		button.pressed.connect(func() -> void: player_move_selected.emit(button.text))


func set_buttons_texts(moves: Array[MoveResource]) -> void:
	for i in range(moves.size()):
		move_buttons[i].text = moves[i].name
