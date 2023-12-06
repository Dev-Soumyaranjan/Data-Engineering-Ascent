from utils import take_two_input_int as take_input, get_sum_of_factors


def is_friendly_pair(num1, num2):
    """Checks if two numbers are friendly pair"""

    # Get the sum of the proper divisors of num1.
    fs1 = get_sum_of_factors(num1)
    # Get the sum of the proper divisors of num2.
    fs2 = get_sum_of_factors(num2)

    # Check if the ratio of the sum of the proper divisors of num1 to num1 is equal to the ratio of the sum of
    # the proper divisors of num2 to num2.
    return fs1 / num1 == fs2 / num2


if __name__ == '__main__':
    # Take the first input from the user
    number1, number2 = take_input()

    if is_friendly_pair(number1, number2):
        print(f'Yes!! {number1} and {number2} are friendly pair.')
    else:
        print(f'No!! {number1} and {number2} are not friendly pair.')
