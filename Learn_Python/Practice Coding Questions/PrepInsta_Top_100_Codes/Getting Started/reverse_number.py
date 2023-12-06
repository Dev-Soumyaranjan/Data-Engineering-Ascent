from utils import take_user_input_int as ui


def rev_num(num):
    rev = 0

    while num != 0:
        # In each iteration, rm will store the remainder of the number
        rem = num % 10
        # The reversed number 'rev' is constructed by shifting its digits left (multiplying by 10) and adding
        # the last digit 'rem'.
        rev = rev * 10 + rem
        # After each iteration number will shorten by 1 digit
        num //= 10

    return rev


if __name__ == '__main__':
    n = ui()
    # Printing reverse number by calling the rev_num() function.
    print(f'reverse of the number {n} is {rev_num(n)}')
