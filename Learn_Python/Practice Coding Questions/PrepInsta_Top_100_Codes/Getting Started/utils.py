# Taking user input for a single integer value
def take_user_input_int():
    while True:
        try:
            number = int(input('Enter number: '))
            # Loop will break while the user enters a valid integer number.
            break
        except ValueError:
            print("Please enter a valid integer number.")
    return number


def take_two_input_int():
    while True:
        try:
            number1 = int(input('Enter first number: '))
            number2 = int(input('Enter second number: '))
            # Loop will break while the user enters a valid integer number.
            break
        except ValueError:
            print("Please enter a valid integer number.")
    return number1,number2


# User input for getting year
def get_year():
    while True:
        try:
            y = int(input('Enter year: '))
            # Loop will break while the user enters a valid integer number.
            break
        except ValueError:
            print("Please enter a valid integer number.")
    return y


# User input for two given ranges
def given_range():
    while True:
        try:
            start = int(input('Enter 1st range: '))
            end = int(input('Enter last range: '))
            break
        except ValueError:
            print("Please enter a valid integer number as range.")
    return start, end


# Validate range value
def take_range():
    # given_range() function will return start and end range. Start and end range will be
    # stored in s and e respectively.

    s, e = given_range()
    # Keep iterating while the start range is greater than the end range.
    while s > e:
        print("Start range should be less than end range")
        s, e = given_range()

    return s, e


def input_greater_than_zero():
    i = take_user_input_int()
    while i == 0:
        print("Input should be more than 0")
        i = take_user_input_int()
    return i


# Printing range values

def print_range_values(r1, r2):
    for i in range(r1, r2 + 1):
        if i == r2:
            print(i, end=' ')
        else:
            print(i, " +", end=' ')


def print_list_values(l):
    for e in l:
        print(e, end=' ')


def get_digits(n):
    d = []
    while n != 0:
        d.append(n % 10)
        n //= 10

    return d[::-1]


# An alternate way to get the digit of the number
# import map
#
# def get_digits(number):
#
#     digits = map(str, str(number))
#     return digits

def get_sum_of_factors(n):
    """Returns the sum of the factors(except number itself) of the given number"""

    # Create an empty list to store the factors of n.
    f = []
    # Create an empty list to store the factors of n.
    for i in range(1, n + 1):
        # If n is divisible by i, then i is a factor of n.
        if n % i == 0:
            # Add i to the list of factors.
            f.append(i)

    # Get the factors of num, excluding the number itself.
    factors = f[:-1]

    # Initialize the sum of factors to 0.
    factor_sum = 0

    # Iterate over the factors of n and add each factor to the sum of factors.
    for e in factors:
        # In each iteration, Add the current factor 'e' to the sum of factors.
        factor_sum += e

    # Returns sum of the factors
    return factor_sum
