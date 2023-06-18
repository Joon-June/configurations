with open("style.yapf", "r") as f:
	text = f.readlines()

text = ", ".join(text).replace("=", ": ").replace("\n", "")
text = "{ " + text + " }"

print(text)
