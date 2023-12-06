from utils import input_greater_than_zero as igtz, print_list_values as pl
from factor_of_number import factor
from CheckPrimeNumber import isPrime


def find_prime_factors(n):
    """Finds the prime factors of a given number."""

    # Get the factors of the given number.
    f = factor(n)
    # Create an empty list to store the prime factors.
    pf = []
    # Iterate over the factors of the given number and check if each factor is prime.
    for i in f:
        # If a factor is prime, add it to the list of prime factors.
        if isPrime(i):
            # Add the prime factor to the list of prime factors.
            pf.append(i)
    # Return the list of prime factors.
    return pf


if __name__ == '__main__':
    # Get the input number from the user.
    num = igtz()

    # used the plural "are" if there are more than one prime factor, or the singular "is" if there is only one prime
    # factor.
    if len(find_prime_factors(num)) > 1:
        print(f'Prime factors of {num} are :')
    else:
        print(f'Prime factor of {num} is :')

    # Print the prime factors of the input number.
    pl(find_prime_factors(num))
