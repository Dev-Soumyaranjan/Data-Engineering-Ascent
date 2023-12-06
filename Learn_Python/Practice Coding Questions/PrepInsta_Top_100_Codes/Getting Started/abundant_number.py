from utils import input_greater_than_zero as take_input, get_sum_of_factors


def is_abundant_number(n):
    # Get the sum of the factors by calling get_sum_of_factors() function
    fs = get_sum_of_factors(n)
    # Return True if the sum of factors is greater than the original number.
    return fs > n


if __name__ == '__main__':
    # Taking user input
    num = take_input()
    # Check if the input number is an abundant number
    if is_abundant_number(num):
        print(f'{num} is an abundant number')
    else:
        print(f'{num} is not an abundant number')
