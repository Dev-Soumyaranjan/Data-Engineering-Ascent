def is_anagrams(input_string1, input_string2):
    return sorted(list(input_string1)) == sorted(list(input_string2))


if __name__ == '__main__':
    user_input_1 = input('Enter first string: ')
    user_input_2 = input('Enter second string: ')
    if is_anagrams(user_input_1.lower(), user_input_2.lower()):
        print(f'Both {user_input_1} and {user_input_2} are anagram')
    else:
        print(f'Both {user_input_1} and {user_input_2} are not anagram')
