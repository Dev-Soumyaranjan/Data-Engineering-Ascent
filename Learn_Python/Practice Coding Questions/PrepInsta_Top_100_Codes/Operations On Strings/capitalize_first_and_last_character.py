def capitalizing_first_last_character(input_string):
   # Initializing the variable to store modified string.
    updated_string = ''
    for w in input_string.split():
        word = w.lower()
        word_update = ''
        for i in range(0, len(word)):
            if i == 0:
                word_update = word_update + word[i].upper()  # sum + = i => sum = sum + i word[0].upper
            elif i == len(word) - 1:
                word_update = word_update + word[i].upper()
            else:
                word_update = word_update + word[i]
        updated_string = updated_string + ' ' + word_update

    return updated_string


if __name__ == '__main__':
    user_input = input('Enter string: ')
    result = capitalizing_first_last_character(user_input)
    print(result)
