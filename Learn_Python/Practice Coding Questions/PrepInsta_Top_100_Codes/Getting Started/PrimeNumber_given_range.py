from utils import take_range as tr
from CheckPrimeNumber import isPrime
from utils import print_list_values

if __name__ == '__main__':
    range1, range2 = tr()
    # all the prime numbers will be stored in primeNumber list
    primeNumber = []
    # It will iterate till the end range
    for n in range(range1, range2 + 1):
        # Calling isPrime() function to check whether the number is prime number or not. If the number is prime
        # number, then it will get append to the primeNumber list
        if isPrime(n):
            primeNumber.append(n)
    # Calling print_list_values() function to print all the elements which are stored inside primeNumber list
    print_list_values(primeNumber)
