def removing_brackets(input_string):
    temp_string = ''
    for c in input_string:
        if ord(c) == 40 or ord(c) == 41:
            continue
        else:
            temp_string = temp_string + c
    return temp_string


if __name__ == '__main__':
    user_input = input('Enter string: ')
    result = removing_brackets(user_input)
    print(f'After removing brackets: {result}')
