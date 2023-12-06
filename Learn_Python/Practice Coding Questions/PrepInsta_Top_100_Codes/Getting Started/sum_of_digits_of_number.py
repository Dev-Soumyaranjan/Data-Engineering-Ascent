from utils import take_user_input_int as ui


# An alternative approach

# def sum_of_digits(num):
#     num_str = str(num)
#     ns = 0
#     for n in num_str:
#         ns += int(n)
#     return ns

def sum_of_digits(num):
    ns = 0
    # It will keep iterating until the number is greater than 0
    while num > 0:
        # In each iteration, rm will store the remainder of the number
        rm = num % 10
        # In each iteration sum value(ns here) will be updated
        ns += rm
        # After each iteration number will shorten by 1 digit
        num //= 10

    return ns


if __name__ == '__main__':
    number = ui()
    print(f'The sum of the digits of {number} is {sum_of_digits(number)}')
