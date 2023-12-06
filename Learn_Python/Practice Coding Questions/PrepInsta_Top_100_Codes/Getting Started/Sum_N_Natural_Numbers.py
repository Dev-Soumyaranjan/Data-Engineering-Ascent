from utils import take_user_input_int as ti
from utils import print_range_values as pv


def sum_n_natural_number(n):
    next_number = n + 1
    nums_sum = (n * next_number) / 2
    return int(nums_sum)


if __name__ == '__main__':
    number = ti()
    if number == 1:
        print("Minimum limit should be more than 1")
    else:
        # result will store the return value of the check_is_Even() function. This function will return
        # either True or False.
        result = sum_n_natural_number(number)
        print("Sum of ", number, " numbers = ", end=' ')
        pv(1, number)
        print(" = ", result)
