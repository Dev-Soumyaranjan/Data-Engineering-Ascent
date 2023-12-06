from utils import input_greater_than_zero as take_input, print_list_values as pl


def factor(n):
    # Create an empty list to store the factors of n.
    f = []
    # Create an empty list to store the factors of n.
    for i in range(1, n + 1):
        # If n is divisible by i, then i is a factor of n.
        if n % i == 0:
            # Add i to the list of factors.
            f.append(i)
    # Return the list of factors.
    return f


if __name__ == '__main__':
    # Taking the user input
    number = take_input()
    print(f'Factors of {number} are', end=' ')
    # Printing factors of the number
    pl(factor(number))
