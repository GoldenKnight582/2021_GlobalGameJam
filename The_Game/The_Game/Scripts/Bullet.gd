extends Area2D

export var speed = 300
export var life_timer = 1.5

func _physics_process(delta):
	life_timer -= delta
	position += transform.x * speed * delta
	
	if life_timer <= 0:
		queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
