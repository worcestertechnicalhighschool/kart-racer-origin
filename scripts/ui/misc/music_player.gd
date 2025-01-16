# This is code for a global music player that SHOULD play various songs from and in multiple scenes, 
# but is unused for now. Dont delete it though, cause it might be brought back later!





#extends AudioStreamPlayer
#
#const menu_music = preload("res://assets/sounds/music/sng_menu.mp3")
#const curvetest_music = preload("res://assets/sounds/music/itbs/finance/sng_finance.mp3")
#
#func _ready() -> void:
	#play_music_level()
#
#func _play_music(music: AudioStream, volume = 0.0):
	#
	#if stream == music:
		#return
	#
	#stream = music
	#volume_db = volume
	#play()
	#
#func play_music_level():
	#if get_tree().current_scene.name == "curve_test":
		#stop()
		#_play_music(curvetest_music)
	#elif get_tree().current_scene.name == "title_screen" or "main_menu" or "track_select":
		#stop()
		#_play_music(menu_music)
