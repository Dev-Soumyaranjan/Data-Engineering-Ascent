from check_alphabet import isalphabet


def removing_extra_character(input_string):
    result_string = ''
    for c in input_string:
        if isalphabet(c):
            result_string = result_string + c
        else:
            continue
    return result_string


if __name__ == '__main__':
    user_input = input("Enter string: ")
    result = removing_extra_character(user_input)
    print(f'After removing extra characters except alphabet: {result}')
