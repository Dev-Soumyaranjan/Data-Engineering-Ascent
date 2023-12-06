from reverse_string import string_reversing


def is_string_palindrome(input_string):
    return input_string == string_reversing(input_string)


if __name__ == '__main__':
    user_input = input('Enter the string: ')
    if is_string_palindrome(user_input.lower()):
        print(f'{user_input} is a palindrome string')
    else:
        print(f'{user_input} is not a palindrome number')
