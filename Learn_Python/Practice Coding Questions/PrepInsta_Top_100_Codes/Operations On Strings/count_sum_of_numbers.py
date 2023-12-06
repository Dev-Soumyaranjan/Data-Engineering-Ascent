def calculate_sum_of_numbers_in_string(input_string):
    num_sum = 0
    for c in input_string:
        if c.isnumeric():
            num_sum = num_sum + int(c)
        else:
            continue
    return num_sum


if __name__ == '__main__':
    user_input = input('Enter string: ')
    result = calculate_sum_of_numbers_in_string(user_input)
    print(f'Total sum of the numbers in {user_input} is {result}')
