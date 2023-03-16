extends CharacterBody3D

## Horizontal Speed (m/s)
@export var speed: float = 14
## Acceleration due to Gravity (m/s²).
@export var fall_acc = 75

func _physics_process(delta: float) -> void:
  ## 2D direction on the horizontal plane
  var direction: Vector2 = Input.get_vector(
    &"move_left", &"move_right",
    &"move_forward", &"move_back"
  ) * speed
  var velocity2: Vector3 = Vector3(direction.x, 0, direction.y)
  
  if !is_on_floor():
    # Fall by gravity
    velocity2.y = velocity.y - fall_acc * delta
  velocity = velocity2
  
  if direction != Vector2.ZERO:
    $Pivot.look_at(position + velocity)
  
  move_and_slide()
