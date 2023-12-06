from utils import input_greater_than_zero as take_input, get_digits
from power_of_number import calculate_power as power


def check_automorphic_number(n):
    """Return True if a number is an automorphic number."""
    # Return True if the last digit of n is equal to the last digit of the square of n.
    return str(get_digits(n)[-1]) == str(power(n, 2))[-1]


if __name__ == '__main__':
    # Taking the input from user 
    number = take_input()
    # Check if the input number is an automorphic number.
    if check_automorphic_number(number):
        print(f'{number} is an automorphic number')
    else:
        print(f'{number} is not an automorphic number')
