from utils import take_user_input_int as ti


# The function will return True if the number is greater than or equal to 0 else it will return false.
def isPositive(num):
    return num >= 0


# Main function
if __name__ == '__main__':
    number = ti()
    # If the number is greater than equal to zero, then if block gets execute.
    if isPositive(number):
        # Since zero is neither positive nor negative number, we should keep this condition which will check whether
        # the number is zero or not
        if number == 0:
            print("You entered zero which is neither positive nor negative.")
        else:
            print("This is a positive number")
    else:
        print("This is a negative number.")
