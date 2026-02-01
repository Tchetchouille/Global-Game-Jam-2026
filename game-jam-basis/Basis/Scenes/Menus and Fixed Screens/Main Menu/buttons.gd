extends VBoxContainer

func _process(_delta: float) -> void:
	resize_buttons()

func resize_buttons():
	var txt_size = get_window().size.y / 30
	$Play.add_theme_font_size_override("font_size", txt_size)
	$Settings.add_theme_font_size_override("font_size", txt_size)
	$Credits.add_theme_font_size_override("font_size", txt_size)
	$Quit.add_theme_font_size_override("font_size", txt_size)

func _on_play_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(MenuMusic, "volume_linear", 0, 1.0)
	await tween.finished
	RMusic.play()
	GMusic.play()
	BMusic.play()
	get_tree().change_scene_to_file("res://Colins_stuff/Level/Level1.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Basis/Scenes/Menus and Fixed Screens/Settings/settings.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Basis/Scenes/Menus and Fixed Screens/Credits/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
