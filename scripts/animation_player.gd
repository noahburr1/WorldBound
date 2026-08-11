extends AnimationPlayer

var direction := Input.get_axis("moveL", "moveR")

func _process(delta: float) -> void:
	if direction > 0:
		play("walk")
	if direction <0:
		play("walk")
	if direction == 0:
		play("idle")
