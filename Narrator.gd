extends Node2D

var player_words = []

var template = [
		{
		"prompt" : ["a mood", "a person", "a activity", "a place", "a person", "a object", "a action"],
		"story" : "It was a %s day, so %s went %s in the %s.  %s saw this so grabbed the nearest %s and started %s it!"
		},
		{
		"prompt" : ["a person", "a thing", "a person", "a mood"],
		"story" : "%s arrived riding a %s, this made %s %s!"
		}
	]
var current_story

func _ready():
	randomize()
	current_story = template [randi() % template.size()]
	$Blackboard/StoryText.text = "Welcome to Loony Lips! \n\n Lets play a game!  I will ask you some questions and create a story from them! \n\n Can I have " + current_story.prompt[player_words.size()] + ", please."
	$Blackboard/EditBox.text = ""

func _on_OKButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/EditBox.get_text()
		_on_EditBox_text_entered(new_text)

func _on_EditBox_text_entered(new_text):
	player_words.append(new_text)
	$Blackboard/EditBox.text = ""
	check_player_word_length()

func is_story_done():
	return player_words.size() == current_story.prompt.size()
	
func prompt_player():
	$Blackboard/StoryText.text = ("Can I have " + current_story.prompt[player_words.size()] + ", please.")

func check_player_word_length():
	if is_story_done():
		tell_story()
		$Blackboard/OKButton/RichTextLabel.text = "Again?"
	else:
		prompt_player()

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	end_game()

func end_game():
	$Blackboard/EditBox.queue_free()