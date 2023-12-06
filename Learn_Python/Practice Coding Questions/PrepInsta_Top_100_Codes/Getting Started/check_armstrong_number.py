from utils import take_user_input_int as ui


def isArmstrong(n):
    # Get the total number of digits in the number.
    td = len(str(n))
    # store the original number in temp variable because post while loop the n value will be changed
    temp = n
    # Initialize the result with 0 and with each iteration it will be updated.
    result = 0
    # Iterate till the number is greater than 0.
    while n > 0:
        # the remainder of the number will be stored in r.
        r = n % 10
        # 'r' is raised to the power of the total number of digits ('td') and added to 'result'.
        result = result + r ** td
        # Number will get shorten by 1 digit in each iteration
        n //= 10

    return temp == result


if __name__ == '__main__':
    num = ui()

    if isArmstrong(num):
        print(f'{num} is an armstrong number')
    else:
        print(f'{num} is an not armstrong number')
