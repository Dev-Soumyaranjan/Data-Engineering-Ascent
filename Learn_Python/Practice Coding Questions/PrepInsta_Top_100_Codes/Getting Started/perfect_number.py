from utils import input_greater_than_zero as take_input, get_sum_of_factors


def find_perfect_number(num):
    # Get the sum of the factors by calling get_sum_of_factors() function
    fs = get_sum_of_factors(num)
    # Return True if the sum of factors is equal to num.
    return num == fs


if __name__ == '__main__':
    # Get the input number from the user.
    number = take_input()

    # Check if the input number is a perfect number.
    if find_perfect_number(number):
        print(f'{number} is a perfect number.')
    else:
        print(f'{number} is not a perfect number.')
