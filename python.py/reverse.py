def reverse_name(name):
    return name[::-1]
user_name = input("Enter your name: ")

reversed_name = reverse_name(user_name)
print("Reversed name:", reversed_name)