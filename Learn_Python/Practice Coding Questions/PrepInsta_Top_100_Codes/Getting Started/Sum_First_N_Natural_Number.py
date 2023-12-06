from utils import take_user_input_int as ti
from utils import print_range_values as pv


def sum_n_natural_Number(num):
    s = 0
    for n in range(0, num + 1):
        s += n
    return s


if __name__ == '__main__':
    number = ti()

    if number == 1:
        print("Minimum limit should be more than 1")
    else:
        # result will store the return value of the check_is_Even() function. This function will return
        # either True or False.
        result = sum_n_natural_Number(number)
        print("Sum of first ", number, " numbers = ", end=' ')
        pv(1, number)
        print(" = ", result)
