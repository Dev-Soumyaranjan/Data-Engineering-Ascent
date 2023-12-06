# from collections import Counter


def calculate_frequency(input_string):
    temp_dict = {}
    for c in input_string:
        if c in temp_dict:
            temp_dict[c] = temp_dict[c] + 1
        else:
            temp_dict[c] = 1
    return temp_dict


if __name__ == '__main__':
    user_input = input('Enter a string: ')
    character_occurence = calculate_frequency(user_input)
    highest_occurence = max(character_occurence.values())
    result = [k for k, v in character_occurence.items() if v == highest_occurence]
    print(result)

"""
    # Alternative way to find the frequency of characters in the given string 
    character_occurence = Counter(user_input)
    max_occurence = max(character_occurence.values())
    result = [k for k, v in character_occurence.items() if v == max_occurence]
    print(result)
"""
