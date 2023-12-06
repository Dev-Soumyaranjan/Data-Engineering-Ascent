def string_reversing(input_string):
    temp_string = ''
    for c in input_string:
        temp_string = c + temp_string
    return temp_string


if __name__ == '__main__':
    user_input = input("Enter the string: ")
    reversed_string = string_reversing(user_input)
    print(f'The reversed string is: {reversed_string}')
