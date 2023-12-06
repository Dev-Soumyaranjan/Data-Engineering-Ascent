from utils import take_user_input_int as ti


def factorial(n):
    """It will return the factorial of the given number"""

    # Initializing fact with 1 which will keep update with each iteration
    fact = 1
    # It will keep iterating util n is not equal to 0
    while n != 0:
        # Multiply the current value of fact by n to calculate the factorial of n.
        fact *= n
        # Value of n will decrease by 1 with each iteration
        n -= 1
    # Returning fact value
    return fact


if __name__ == '__main__':
    num = ti()
    result = factorial(num)
    print(f'Factorial number of {num} is {result}')
