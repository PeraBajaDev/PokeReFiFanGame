class_name DomainValidator


static func positive_int(value: int) -> void:
	if value <= 0:
		push_warning("Trying to assing a negative value. Integer value should be positive")


static func not_empty_string(value: String) -> void:
	if value.is_empty():
		push_error("Trying to assing an empty string. String should have content")
		return
