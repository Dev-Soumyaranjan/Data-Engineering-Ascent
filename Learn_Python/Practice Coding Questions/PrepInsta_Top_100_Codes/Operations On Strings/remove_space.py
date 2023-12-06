def removing_space(input_string):
    temp_string = ''
    for c in input_string:
        if ord(c) == 32:
            continue
        else:
            temp_string = temp_string + c
    return temp_string


if __name__ == '__main__':
    user_input = input('Enter string: ')
    result = removing_space(user_input)
    print(f'After removing space: {result}')
