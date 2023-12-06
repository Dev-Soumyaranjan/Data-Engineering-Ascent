from check_vowel_consonant import isvowel


def remove_vowel(mystring):
    temp_string = ''
    for c in mystring:
        if not isvowel(c):
            temp_string = temp_string + c
        else:
            continue

    return temp_string


if __name__ == '__main__':
    user_input = input("Enter string: ")
    result = remove_vowel(user_input.lower())
    print(f'After removing vowel: {result}')
