
def find_string_length(s):
    count = 0
    for _ in s:
        count = count + 1
    return count


if __name__ == '__main__':
    take_input = input('Enter a string: ')
    string_length = find_string_length(take_input)
    print(f'Length of the given string is {string_length}')
