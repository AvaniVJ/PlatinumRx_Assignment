text = input("Enter string: ")

result = ""
seen = set()

for char in text:
    if char.lower() not in seen:
        seen.add(char.lower())
        result += char

print("Unique string:", result)
