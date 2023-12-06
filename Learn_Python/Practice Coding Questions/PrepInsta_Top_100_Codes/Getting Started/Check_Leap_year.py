from utils import get_year as gy

'''
Condition to check if year is a leap year or not:
         * For first condition --> The year must be divisible by 400 ->(Year % 400 == 0)
         * For second condition --> The year must be divisible by 4 but not 100 ->(Year% 4 == 0)&(Year % 100 != 0))
         * Since either of the conditions should satisfy we should use OR(|) operator

'''


# If given condition (To check year is leap year or not) satisfies, then it returns True otherwise False
def isLeapYear(y):
    return (year % 400 == 0) or ((year % 4 == 0) and (year % 100 != 0))


if __name__ == '__main__':
    year = gy()
    # r will store the return value of isLeapYear(which is either True or False) function
    r = isLeapYear(year)
    # If function returns True then if block is executed otherwise else block will be executed
    if r:
        print(f'The entered year {year} is a leap year')
    else:
        print(f'The entered year {year} is not a leap year')
