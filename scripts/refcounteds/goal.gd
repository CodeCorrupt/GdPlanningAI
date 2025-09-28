## A GdPAI agent's goal defines a reward level and a required state to satisfy the goal.
class_name Goal
extends RefCounted

var name := ""

## Initialize the goal with a name.
func _init(name: String = ""):
	if name == "":
		name = "Goal_%s" % str(self.get_instance_id())
	self.name = name

## How rewarding is this goal to complete?  This can depend on dynamic factors (i.e. eating is
## more rewarding if an agent is hungry).
func compute_reward(agent: GdPAIAgent) -> float:
	return 0


## What do the agent's blackboard and world state need to contain for the goal to be satisfied?
##[br]
##[br]
## Returns an array of preconditions.
func get_desired_state(agent: GdPAIAgent) -> Array[Precondition]:
	return []


## Mark the goal as satisfied.
func mark_goal_satisfied(agent: GdPAIAgent):
	var last_time_goals_satisfied: Dictionary = agent.blackboard.get_property("GDPAI_GOALS_SATISFIED_TIMES", {})
	if not last_time_goals_satisfied:
		last_time_goals_satisfied = {}
	last_time_goals_satisfied[name] = Time.get_ticks_msec()
	agent.blackboard.set_property("GDPAI_GOALS_SATISFIED_TIMES", last_time_goals_satisfied)


## Get the time since the goal was last satisfied.
func time_since_satisfied(agent: GdPAIAgent) -> int:
	var last_time_goals_satisfied: Dictionary = agent.blackboard.get_property("GDPAI_GOALS_SATISFIED_TIMES", {})
	var current_time: int = Time.get_ticks_msec()
	if not last_time_goals_satisfied.has(name):
		return current_time - 0
	return current_time - last_time_goals_satisfied[name]
