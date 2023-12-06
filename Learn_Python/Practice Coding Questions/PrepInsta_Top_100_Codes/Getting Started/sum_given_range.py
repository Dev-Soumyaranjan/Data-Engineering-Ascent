from utils import take_range as tr

if __name__ == '__main__':
    r1, r2 = tr()
    sum_rv = 0
    for num in range(r1, r2 + 1):
        sum_rv += num

    print("Sum of all the numbers between", r1, " and ", r2, "(including", r1, "&", r2, ") is", sum_rv)
