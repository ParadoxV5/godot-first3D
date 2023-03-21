extends CharacterBody3D

@export var min_speed: float
@export var max_speed: float
@export_range(0, 90) var rotate_range: float = 45

signal squashed

func _physics_process(_delta) -> void: move_and_slide()

func setup_position(start_position: Vector3, player_position: Vector3):
  player_position.y = 0
  look_at_from_position(position + start_position, player_position, Vector3.UP)
  rotate_y(deg_to_rad(randf_range(-rotate_range, rotate_range)))
  velocity = (
    Vector3.FORWARD * randf_range(min_speed, max_speed)
  ).rotated(Vector3.UP, rotation.y)

func squash():
  squashed.emit()
  queue_free()

func _on_visible_notifier_screen_exited() -> void: queue_free()
