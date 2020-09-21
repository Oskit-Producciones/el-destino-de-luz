extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("Brillar")
	yield(get_tree().create_timer(1.0),"timeout")
	Main.emit_signal("FadeOutWhite")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Brillar":
		Main.emit_signal("PlayerWin")
