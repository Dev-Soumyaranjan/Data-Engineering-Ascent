if __name__ == '__main__':
    # Taking user input by calling take_utils_int() defined in utils.py
    firstNum = int(input('Enter first number: '))
    secondNum = int(input('Enter second number: '))

    # I have used ternary operator in python using if-else. The First print statement will be executed if the
    # condition is true, otherwise the second print will be executed
    print(firstNum, " is greater than ", secondNum) if firstNum > secondNum else print(secondNum, " is greater than ",
                                                                                       firstNum)
