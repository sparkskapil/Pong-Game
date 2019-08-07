extends KinematicBody2D

#Signals for Paddle
#emit this when paddle collides with another node.
signal paddle_collision

#velocity of the paddle changes on UP and DOWN Key Press
var m_velocity = Vector2.ZERO

#initial speed for paddle can be set from the Inspector as well 
export(int) var Speed
#Key to be mapped for moving the paddle in UP Direction
export var UP_KEY:String 
#Key to be mapped for moving the paddle in DOWN Direction
export var DOWN_KEY:String

func _ready():
	#LOG AN ERROR IF THE PADDLE CONTROLS ARE NOT SET
	if UP_KEY == "" || DOWN_KEY == "":
		printerr( "Controls not set for " + get_name())

func _physics_process(delta):
	#get the collision object when moved with m_velocity
	var collision = move_and_collide(m_velocity*delta)
	#if the collision is detected emit the signal 'paddle_collision'
	if collision:
		emit_signal("paddle_collision",collision)

func _input(event):
	#check whether the event is Keyboard Key Pressed Event
	if event is InputEventKey && event.is_pressed():
		#Check the text for Key Pressed with UP_KEY 
		if event.as_text() == UP_KEY:
			up_key_pressed()
		#Check the text for Key Pressed with DOWN_KEY
		elif event.as_text() == DOWN_KEY && event.is_pressed():
			down_key_pressed()

	#check whether the event is Keyboard Key Released Event
	elif event is InputEventKey && !event.is_pressed(): 
		key_released()		 

func up_key_pressed():
	"""
	This method will be called when UpKey is pressed.
	Will change the direction of the paddle velocity.
	Will make the paddle to move in UP Direction
	"""
	m_velocity = Vector2.UP * Speed;

func down_key_pressed():
	"""
	This method will be called when DownKey is pressed.
	Will change the direction of the paddle velocity.
	Will make the paddle to move in DOWN Direction
	"""
	m_velocity = Vector2.DOWN * Speed;

func key_released():
	#Will Stop the paddle on Key Release
	self.paddle_stop()

#Method when called will set the velocity to ZERO
#Hence stopping the paddle.
func paddle_stop():
	"""
	This method will be called when Key is released.
	Will make the paddle velocity ZERO.
	Will make the paddle to Stop
	"""
	m_velocity = Vector2.ZERO;