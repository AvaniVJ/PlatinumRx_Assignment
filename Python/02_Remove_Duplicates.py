# Remove duplicate characters from string using loop

text = input("Enter string: ")

result = ""

for char in text:
    if char not in result:
        result = result + char

print("Unique string:", result)