extends Node

@export var mob_scene: PackedScene
@export var spawn_distance: float

func _on_mob_spawn_timer_timeout() -> void:
  var mob: CharacterBody3D = mob_scene.instantiate()
  mob.squashed.connect($UI/Score._on_Mob_squashed)
  # Unlike the Tuturial, this time I’m using a circularly
  # rotated `Vector3` to randomize the `start_position`
  mob.setup_position(
    (Vector3.FORWARD * spawn_distance).rotated(Vector3.UP, randf_range(0, TAU)),
    $Player.position
  )
  add_child(mob)

# $UI/GameoverOverlay.visible => if game is over
func _ready():
  $UI/GameoverOverlay.hide()
func _on_player_hit() -> void:
  $MobSpawnTimer.stop()
  $UI/GameoverOverlay.show()
func _unhandled_input(event):
  if $UI/GameoverOverlay.visible and event.is_action_pressed(&"ui_accept"):
    get_tree().reload_current_scene()
