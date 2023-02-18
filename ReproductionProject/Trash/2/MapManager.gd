extends Node

var loaders: Array
var map_cache: Dictionary

func load_map(map: String) -> PackedScene:
	if not map in map_cache:
		map_cache[map] = load(get_map_path(map))
#	refresh_cache(map) ##laguje
	return map_cache[map] as PackedScene

func refresh_cache(map: String):
	var to_remove := map_cache.duplicate()
	to_remove.erase(map)
	
	for neighbor in Autoload.maps_by_filename[map].neighbors:
		if neighbor in map_cache:
			to_remove.erase(neighbor)
		else:
			for loader in loaders:
				if loader.map == neighbor:
					continue
			
#			loaders.append({map = neighbor, interactive = ResourceLoader.load_interactive(get_map_path(neighbor))})
	
	for cached_map in to_remove: ##w sumie można trzymać X ostatnich map
		map_cache.erase(cached_map)
	
	set_process(true)

func _process(delta: float) -> void:
	var loaded: Array
	
	for loader in loaders:
		if loader.interactive.poll() == ERR_FILE_EOF:
			map_cache[loader.map] = loader.interactive.get_resource()
			loaded.append(loader)
	
	for loader in loaded:
		loaders.erase(loader)
	
	if loaders.is_empty():
		set_process(false)

func get_map_path(map: String) -> String:
	return "res://Maps".plus_file(Autoload.maps_by_filename[map].world).plus_file(map) + ".tscn"
