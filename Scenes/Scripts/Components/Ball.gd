extends KinematicBody2D

#Signals for Ball
#emit this when ball collides with another node.
signal ball_collision 

#velocity of the ball changes on collision
var m_velocity = Vector2.ZERO

#Initial Magnitude of the ball's velocity
#Can be set from the inspector as well
export var Speed: int;

func _ready():
	"""
	Initializes the ball Node
	Get the viewport size and places the ball in the center
	Choose and initialize velocity with a random direction
	"""
	randomize()
	#get size of viewport
	var size = get_viewport_rect().size
	#set balls position in the center
	set_position(size/2)
	#choose random direction in x
	#rotate the vector by random value between -PI/4 to PI/4
	#get the unit vector along the direction
	var direction = Vector2(rand_range(-1,1),0).rotated(rand_range(-0.25,0.25)*PI).normalized()
	#multiply the direction with the magniture
	#store the result in the velocity
	m_velocity = direction*Speed

func _physics_process(delta):
	"""
	While working with KinematicBody2D Node, we should use 
	_physics_process which is independent of the framerate
	The delta value for every frame will be constant
	This is where the physics calculation should happen
	"""
	#move_and_collide returns a KinematicCollision2D 
	#if the collision is detected else return null 
	var collision = move_and_collide(m_velocity * delta)
	#if a collision is detected, emit the 'ball_collision' signal
	if collision:
		emit_signal("ball_collision", collision)

#this method allows the ball to bounce off the 
#colliding surface
func ball_bounce(normal, y_drag):
	"""
	This method takes a normal to the colliding surface and
	y_drag, it updates the velocity to the bounce velocity
	and add y_drag to the y-component of the velocity
	"""
	m_velocity = m_velocity.bounce(normal)
	m_velocity.y += y_drag;

#respawns the ball 
#used when the ball hits the side walls

func ball_reset():
	_ready()
