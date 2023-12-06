from check_vowel_consonant import isvowel


def total_vowels(input_string):
    vowel_count = 0
    for c in input_string:
        if isvowel(c):
            vowel_count = vowel_count + 1
        else:
            continue
    return vowel_count


if __name__ == '__main__':
    user_input = input('Enter string: ')
    result = total_vowels(user_input.lower())
    print(f'Total number of vowel: {result}')
