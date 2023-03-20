extends Node

@export var mob_scene: PackedScene
@export var spawn_distance: float

func _on_mob_spawn_timer_timeout() -> void:
  var mob: CharacterBody3D = mob_scene.instantiate()
  # Unlike the Tuturial, this time I’m using a circularly
  # rotated `Vector3` to randomize the `start_position`
  mob.setup_position(
    (Vector3.FORWARD * spawn_distance).rotated(Vector3.UP, randf_range(0, TAU)),
    $Player.position
  )
  add_child(mob)
