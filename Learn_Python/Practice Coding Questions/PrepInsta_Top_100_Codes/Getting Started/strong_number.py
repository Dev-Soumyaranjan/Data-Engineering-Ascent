from utils import input_greater_than_zero as take_input, get_digits
from facotrial_of_number import factorial


def find_strong_number(n):
    # Initialize the sum of factorials to 0.
    factorial_sum = 0
    # Get the digits of n.
    digits = get_digits(n)
    # Iterate over the digits of n and add the factorial of each digit to the sum of factorials
    for d in digits:
        # Add the factorial of the current digit to the sum of factorials.
        factorial_sum += factorial(d)
    # Return True if the sum of factorials is equal to the original value of n.
    return factorial_sum == n


if __name__ == '__main__':
    # Get the input number from the user.
    num = take_input()
    # Check if the input number is a strong number.
    if find_strong_number(num):
        print(f'{num} is a strong number')
    else:
        print(f'{num} is not a strong number')
