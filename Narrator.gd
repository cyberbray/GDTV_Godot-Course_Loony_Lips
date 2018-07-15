extends Node2D

var player_words = []
var current_story
var strings # text displayed to the player

func _ready():
	set_random_story()
	strings = get_from_json("other_strings.json")
	$Blackboard/StoryText.text = strings["intro_text"]
	prompt_player()
	$Blackboard/EditBox.text = ""

func set_random_story():
	var stories = get_from_json("stories.json")
	randomize()
	current_story = stories [randi() % stories.size()]

func get_from_json(filename):
	var file = File.new() #the file object
	file.open(filename, File.READ) #Assuming the file exists
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_OKButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/EditBox.get_text()
		_on_EditBox_text_entered(new_text)

func _on_EditBox_text_entered(new_text):
	player_words.append(new_text)
	$Blackboard/EditBox.text = ""
	$Blackboard/StoryText.text = ""
	check_player_word_length()

func is_story_done():
	return player_words.size() == current_story.prompt.size()
	
func prompt_player():
	var next_prompt = current_story["prompt"][player_words.size()]
	$Blackboard/StoryText.text += (strings["prompt"] % next_prompt)

func check_player_word_length():
	if is_story_done():
		tell_story()
		$Blackboard/OKButton/RichTextLabel.text = "Again?"
	else:
		prompt_player()

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	$Blackboard/OKButton/RichTextLabel.text = strings["again"]
	end_game()

func end_game():
	$Blackboard/EditBox.queue_free()