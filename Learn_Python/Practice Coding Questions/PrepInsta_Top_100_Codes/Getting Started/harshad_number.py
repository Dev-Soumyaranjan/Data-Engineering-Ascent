from utils import input_greater_than_zero as take_input, get_digits


def is_harshad_number(num):
    """Return True if a number is a Harshad number."""
    # Get the digits of num.
    digits = get_digits(num)
    # Initialize the sum of the digits of num.
    ds = 0
    # Iterate over the digits of num and add each digit to the sum of digits.
    for e in digits:
        ds += e
    # Check if num is divisible by the sum of its digits.
    return num % ds == 0


if __name__ == '__main__':
    # Taking user input
    n = take_input()
    # Check if the input number is a Harshad number.
    if is_harshad_number(n):
        print(f'{n} is a harshad number')
    else:
        print(f'{n} is not a harshad number')
