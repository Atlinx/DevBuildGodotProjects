@tool
extends EditorScript

func _run() -> void:
	OS.crash("ded")

#func _run() -> void:
#	var meme = Meme.new()
#
#	var tw: Tween = Engine.get_main_loop().create_tween()
#	tw.tween_property(meme, "a", Vector2(1, 2), 0.5)
#	tw.tween_callback(func(): print(meme.a))
#
#class Meme extends Object:
#	var a: int
