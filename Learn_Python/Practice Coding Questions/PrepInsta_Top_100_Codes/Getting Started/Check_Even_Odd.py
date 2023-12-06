from utils import take_user_input_int as ti


# It will return True is the number is evenly divisible by 2 otherwise it will return false.
# I have used ternary operator in python using if-else statement.
def check_is_Even(n):
    return True if n % 2 == 0 else False


if __name__ == '__main__':
    num = ti()
    # result will store the return value of check_is_Even() function. And this function will return
    # either True or False.
    result = check_is_Even(num)
    # If the result is True then if block will get execute otherwise else block will get execute.
    if result:
        print("The entered number is an even number.")
    else:
        print("The entered number is an odd number.")
