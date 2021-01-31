extends KinematicBody2D

export (PackedScene) var Bullet
export var speed = 150
export var shoot_delay = 0.5
var shoot_timer = shoot_delay
export var health = 6
export var damage_delay = 1.5
var damage_timer = damage_delay
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_timer = 0
	shoot_timer = 0

func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $BulletSpawner.global_transform

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("shoot"):
		if shoot_timer <= 0:
			shoot()
			shoot_timer = shoot_delay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)
		
func _process(delta):
	shoot_timer -= delta
	damage_timer -= delta
	if health <= 0:
		queue_free()

func _on_PickupRadius_area_entered(area):
	if area.is_in_group("pickups"):
		area.get_target(self)
		print(area.position.distance_to(position))
