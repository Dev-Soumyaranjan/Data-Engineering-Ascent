from fibonacci_series import return_fibonacci_series as fibo


def nth_term_fibo_series(t):
    """It will return the last element of the list return by return_fibonacci_series function."""
    return fibo(t)[-1]


if __name__ == '__main__':
    term = int(input("Which term of fibonacci series you want: "))
    if term > 0:
        print(f'Fibonacci series of the entered term is {nth_term_fibo_series(term)}')
    else:
        print('term should be greater than 0')
