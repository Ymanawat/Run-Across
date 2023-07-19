extends TileMap

@export var screenWidth = 800   # Width of the screen in pixels
var tile_size = Vector2(80, 16)
var player
var tile1Index = 0   # Index of tile1 in the TileSet
var tile2Index = 1   # Index of tile2 in the TileSet
var next_tile_position
var prev_tile_position
const y_pos = 11
var playerPosition
signal game_over
signal score
var soundPlayed = false

func _ready():
	player = $"../Player"
	playerPosition = player.position
	next_tile_position = map_to_local(Vector2i(0, y_pos))
	prev_tile_position = map_to_local(Vector2i(-1, y_pos))
	generate_tiles()

func generate_tiles():
	while next_tile_position.x < (playerPosition.x + screenWidth):
		var value = randi_range(1,5)
		for i in range(value):
			set_cell(0, local_to_map(next_tile_position), tile1Index, Vector2i(0,0))
			next_tile_position.x += tile_size.x
		set_cell(0, local_to_map(next_tile_position), tile2Index, Vector2i(0,0))
		next_tile_position.x += tile_size.x

func remove_cells():
	while prev_tile_position.x < playerPosition.x - 160.0:
		erase_cell(0, local_to_map(prev_tile_position))
		prev_tile_position.x += tile_size.x
	
func _process(delta):
	if player!=null:
		playerPosition = player.position
	
	if next_tile_position.x < (playerPosition.x + screenWidth):
		generate_tiles()
	
	if prev_tile_position.x < playerPosition.x - 160.0:
		remove_cells()
	
	# Check for collision with tile1
	var tile1CellPos = local_to_map(playerPosition)
	var tile1I = get_cell_source_id(0, tile1CellPos)
	if tile1I == tile1Index:
		if not soundPlayed:
			$"../Game_over".play()
			soundPlayed = true
		emit_signal("game_over")
		
	# Check for collision with tile1
	var tile2CellPos = local_to_map(playerPosition)
	var tile2I = get_cell_source_id(0, tile2CellPos)
	if tile2I == tile2Index:
		$"../Hit_sound".play()
		set_cell(0, tile2CellPos, -1)
		emit_signal("score")
		

