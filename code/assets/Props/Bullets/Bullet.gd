extends KinematicBody2D

var velocidad := Vector2(200.0,0.0)
var Explosion

onready var fx_dead := ($fx_dead)

func _ready():	
	if Main.isGLES2():
		Explosion = preload("res://assets/FX/fx_bullet_explosion_cpu.tscn")
		remove_child($Particles2D)
	else:
		Explosion = preload("res://assets/FX/fx_bullet_explosion.tscn")
		remove_child($Particles2D2)
	
	velocidad = velocidad.rotated(global_rotation)

func _on_spike_body_entered(body):
	if body.is_in_group("player"):
		body.give_hit()
		
var isAlive := true

func _physics_process(delta):
	if isAlive:
		var collision = move_and_collide(velocidad*delta)
		if collision:
			isAlive = false
			explode()
			if collision.collider.has_method("hit"):
				collision.collider.hit()
			
			yield(get_tree().create_timer(0.1),"timeout")
			queue_free()

func explode():
	var boom = Explosion.instance()
	boom.position = position
	get_parent().add_child(boom)
	fx_dead.play()
	#get_tree().current_scene.add_child(boom)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
