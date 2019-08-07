extends Node2D

#References to child nodes
#Ball Node
onready var ball = $Ball
#Label Node for Player1's Score
onready var Score_P1 = $Score_P1
#Label Node for Player2's Score
onready var Score_P2 = $Score_P2

#Variables to track each player's score
var Player_1_Score = 0
var Player_2_Score = 0

#Constant by which score should be updated
const SCORE_STEP = 1;

func _ready():
	#Listen to 'ball_collision signal'
	#Call _on_collision method when the signal is emitted
	ball.connect("ball_collision", self, "_on_collision")

#handler for the 'ball_collision'
func _on_collision(collision):
	"""
	This is the main game logic
	If ball collides with LeftWall Player2 gets the score,
	if ball collides with RightWall Player1 gets the score
	and the ball is respawned in both the cases.
	
	If the ball hits the paddle it gets bounced and 
	the half of the y-component of the paddle's velocity
	is added as y_drag to the balls velocity.
	
	Else the ball bounces normally without any y_drag.
	"""
	var colliding_body = collision.collider; 
	if colliding_body.name == "LeftWall":
		ball.ball_reset()
		Player_2_Score += SCORE_STEP
		Score_P2.text = str(Player_2_Score)

	elif colliding_body.name == "RightWall":
		ball.ball_reset()
		Player_1_Score += SCORE_STEP
		Score_P1.text = str(Player_1_Score)

	elif colliding_body.name == "Paddle_Player_1" || colliding_body.name == "Paddle_Player_2":
		ball.ball_bounce(collision.normal,colliding_body.m_velocity.y/2)

	else:
		ball.ball_bounce(collision.normal,0)