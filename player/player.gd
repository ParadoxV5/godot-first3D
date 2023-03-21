extends CharacterBody3D

## Horizontal Speed (m/s)
@export var speed: float
## Jump Impulse Speed (m/s)
@export var jump_impulse: float = 20
## Squash Bounce Impulse Speed (m/s)
@export var bounce_impulse: float = 15
## Acceleration due to Gravity (m/s²)
@export var fall_acc: float = 75

func _physics_process(delta: float) -> void:
  ## 2D direction on the horizontal plane
  var direction: Vector2 = Input.get_vector(
    &"move_left", &"move_right",
    &"move_forward", &"move_back"
  ) * speed
  var velocity2: Vector3 = Vector3(direction.x, 0, direction.y)
    # Currently only a 3D horizontal-only direction
  
  if direction != Vector2.ZERO:
    $Pivot.look_at(position + velocity2)
  
  # Find the Y component of `velocity2` and apply it
  if is_on_floor():
    for i in range(get_slide_collision_count()):
      var collision: KinematicCollision3D = get_slide_collision(i)
      var collider: CollisionObject3D = collision.get_collider()
      if (
        collider and
        collider.is_in_group(&"mob") and
        collision.get_normal().dot(Vector3.UP) > 0.5 # check hitting from above
      ):
        collider.squash()
        velocity2.y = bounce_impulse
    # Feature not Bug: Can jump at the same frame as a collision
    if Input.is_action_just_pressed(&"jump"):
      velocity2.y = jump_impulse
  else:
    velocity2.y = velocity.y - fall_acc * delta # Fall by gravity
  velocity = velocity2
  
  move_and_slide()
