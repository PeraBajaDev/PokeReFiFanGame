@tool
extends EditorScript

const MOVES_FILE_PATH := "res://moves.txt"

@export var OUTPUT_DIR := "res://Battle/Moves/Resources/"


func _run() -> void:
	var file := FileAccess.open(MOVES_FILE_PATH, FileAccess.READ)
	if not file:
		printerr("No se pudo abrir el archivo moves.txt en: ", MOVES_FILE_PATH)
		return

	DirAccess.make_dir_absolute(OUTPUT_DIR)

	var content := file.get_as_text()
	file.close()

	var sections := content.split("#-------------------------------")
	var imported_count: int = 0

	for section in sections:
		var trimmed := section.strip_edges()
		if trimmed.is_empty():
			continue

		var lines := trimmed.split("\n")
		var move_key := ""
		var move_data := { }

		for line in lines:
			var line_str := line.strip_edges()
			if line_str.is_empty() or line_str.begins_with("#"):
				continue

			if line_str.begins_with("[") and line_str.ends_with("]"):
				move_key = line_str.substr(1, line_str.length() - 2)
				continue

			var key_value := line_str.split("=", true, 1)
			if key_value.size() == 2:
				var key := key_value[0].strip_edges()
				var val := key_value[1].strip_edges()
				move_data[key] = val

		if move_key.is_empty() or not move_data.has("Name"):
			continue

		var move_res := MoveResource.new()
		move_res.name = move_data.get("Name", "")

		if move_data.has("Power"):
			move_res.power = move_data["Power"] as int
		if move_data.has("Accuracy"):
			move_res.accuracy = move_data["Accuracy"] as int
		if move_data.has("TotalPP"):
			move_res.max_power_points = move_data["TotalPP"] as int
		if move_data.has("Description"):
			move_res.description = move_data["Description"]
		if move_data.has("EffectChance"):
			move_res.effect_chanche = move_data["EffectChance"] as int
		if move_data.has("Priority"):
			move_res.priority = move_data["Priority"] as int

		if move_data.has("Type"):
			var type_name := (move_data["Type"] as String).to_upper()
			if TypeManager.Types.has(type_name):
				move_res.type = TypeManager.Types[type_name]

		if move_data.has("Category"):
			var cat_name := (move_data["Category"] as String).to_upper()
			if MoveResource.Category.has(cat_name):
				move_res.category = MoveResource.Category[cat_name]

		if move_data.has("Flags"):
			var flags_array := (move_data["Flags"] as String).split(",")
			for f: String in flags_array:
				move_res.flags.append(f.strip_edges())

		var file_name := move_key.to_lower() + "_move.tres"
		var full_path := OUTPUT_DIR + file_name

		var err := ResourceSaver.save(move_res, full_path)
		if err == OK:
			imported_count += 1
		else:
			printerr("Error al guardar recurso: ", full_path)

	print("¡Importación finalizada con éxito! Total de movimientos importados: ", imported_count)
