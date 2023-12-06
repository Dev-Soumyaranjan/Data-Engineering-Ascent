from utils import take_user_input_int as ui
from reverse_number import rev_num


def isPalindrome(n):
    """It will return True if the given number is equal to it's reverse otherwise it will return false"""
    return n == rev_num(n)


if __name__ == '__main__':

    number = ui()

    if isPalindrome(number):
        print(f'{number} is a palindrome number')
    else:
        print(f'{number} is not a palindrome number')
