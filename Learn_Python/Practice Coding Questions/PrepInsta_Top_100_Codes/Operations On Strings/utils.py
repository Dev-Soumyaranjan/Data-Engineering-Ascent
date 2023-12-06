def get_character():
    while True:
        try:
            c = input("Enter a character: ")
            if len(c) == 1:
                break
            else:
                raise ValueError("Invalid input.Please enter a single character")
        except ValueError as error:
            print(f"Error: {error}")
    return c


def getstring():
    while True:
        try:
            myString = input("Enter a string: ")

            if myString.isalpha():
                break
            else:
                raise ValueError("Invalid input. Please enter a valid string without any special characters or numbers.")
        except ValueError as error:
            print(f"Error: {error}")
    return myString
