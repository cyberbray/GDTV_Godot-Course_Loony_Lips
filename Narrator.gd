extends Node2D

func _ready():
	var prompt = ["hot", "John", "swim", "pond", "Amy", "rabbit", "tickling"]
	var story = "It was a %s day, so %s went for a %s in the %s!  %s saw this so grabbed the nearest %s and started %s it!"
	print (story % prompt)
	$Blackboard/StoryText.text = story % prompt
	$Blackboard/EditBox.text = ""

func _on_OKButton_pressed():
	var new_text = $Blackboard/EditBox.get_text()
	_on_EditBox_text_entered(new_text)

func _on_EditBox_text_entered(new_text):
	$Blackboard/StoryText.text = new_text
	$Blackboard/EditBox.text = ""