extends CharacterBody2D

@export var rotationSpeed = 16.0   # Speed of rotation

enum State{
	IDLE,
	MOVE
}

var screenWidth
var screenHeight
var startPosition
var targetPosition
var moveDistance
var player_state
var offset = Vector2(0, 10.0)

func _ready():
	player_state = State.IDLE
	screenWidth = get_viewport_rect().size.x
	screenHeight = get_viewport_rect().size.y
	moveDistance = screenHeight/2
	startPosition = Vector2((screenWidth/4)*3, (screenHeight/4)*3) # Changed from screenHeight
	targetPosition = Vector2(screenWidth/4, screenHeight/4) # Changed from screenHeight

func _input(event):
	if event.is_action_pressed("ui_accept", false) and player_state == State.IDLE:
		toggle_movement()
		player_state = State.MOVE
	
func toggle_movement():
	offset.y*=(-1)
	var temp = startPosition
	startPosition = targetPosition
	targetPosition = temp
	
func _physics_process(delta):
	
	if (player_state == State.IDLE):
		rotation = 0
		moveDistance=screenHeight/2
		
	if (player_state == State.MOVE):
		position-=offset
		moveDistance-=abs(offset.y)*1.1
		var angle = atan2(velocity.y, velocity.x)
		rotation += rotationSpeed * delta
		
	if((moveDistance)<=0):
		print("stopped")
		player_state = State.IDLE
