def non_repeated_characters(input_string):
    ts = []
    for c in input_string:
        if input_string.count(c) > 1:
            continue
        else:
            ts.append(c)

    return ts


if __name__ == '__main__':
    user_input = input('Enter String: ')
    result = non_repeated_characters(user_input.lower())
    print("Non repeated characters are: ", end=' ')
    for e in result:
        print(e, end=' ')
