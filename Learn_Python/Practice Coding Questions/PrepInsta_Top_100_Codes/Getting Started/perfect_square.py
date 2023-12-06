from utils import input_greater_than_zero as take_input
from power_of_number import calculate_power as power
import math


def perfect_square_number(n):
    """Finds if a number is a perfect square number"""
    # return True if the square of the square root of n is equal to n.
    return power(int(math.sqrt(n)), 2) == n


if __name__ == '__main__':
    # Taking input from the user
    num = take_input()
    # Printing whether the given number is a perfect square number or not
    print(perfect_square_number(num))
