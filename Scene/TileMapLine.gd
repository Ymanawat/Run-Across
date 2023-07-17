extends TileMap

@export var screenWidth = 800   # Width of the screen in pixels
var tile_size = Vector2(80,16)
var player
var tile1Index = 0   # Index of tile1 in the TileSet
var tile2Index = 1   # Index of tile2 in the TileSet

func _ready():
	player = get_node("/root/Player")   # Replace "/root/Player" with the path to your player node
	generate_initial_tiles()

func generate_initial_tiles():
	var playerPosition = player.position
	var tilePosition = playerPosition

	while tilePosition.x < playerPosition.x + 2 * screenWidth:
		if tilePosition.x % (tile_size.x * 6) == 0:
			generate_consecutive_tiles(tilePosition)
		else:
			generate_alternative_tiles(tilePosition)
		tilePosition.x += tile_size.x

func generate_consecutive_tiles(position):
	for i in range(6):
		var cellPosition = local_to_map(position)
		set_tile_at(cellPosition, tile1Index)
		position.x += tile_size.x

func generate_alternative_tiles(position):
	var cellPosition = local_to_map(position)
	set_tile_at(cellPosition, tile2Index)

func _process(delta):
	var playerPosition = player.position
	var screenBoundary = playerPosition.x - screenWidth

	for x in range(get_used_cells_by_id().size()):
		var tilePosition = cell_to_world(get_used_cells_by_id()[x])
		if tilePosition.x < screenBoundary:
			remove_tile(get_used_cells_by_id()[x])

func remove_tile(cell):
	set_tile_at(cell, -1)  # Set the tile ID to -1 to remove the tile
