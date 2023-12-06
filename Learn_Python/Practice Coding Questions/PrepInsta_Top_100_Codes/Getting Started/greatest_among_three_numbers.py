from utils import take_user_input_int as ti

if __name__ == '__main__':
    fn = ti()
    sn = ti()
    tn = ti()
    # Compare first number with second number. If the first number is greater than the second number, then if-block
    # is executed
    if fn > sn:
        # Since the first number is already greater than the second number, so now it will compare with the third
        # number. If this time First number is greater than the third number, then the first number will be greatest
        # among all else third number will be greatest among all since the first number is already greater than the
        # second number.
        if fn > tn:
            print(f"{fn} is largest number among {fn},{sn} and {tn}")
        else:
            print(f"{tn} is largest number among {fn},{sn} and {tn}")
    # If the first number is not greater than the second number, then it will compare second number with third
    # number. If second number is greater than third number, then second number will be greatest among all as second
    # number is already greater than first number. Otherwise, if the second number isn't greater than the third,
    # then the third number will be greatest among all.
    elif sn > tn:
        print(f"{sn} is largest number among {fn},{sn} and {tn}")
    else:
        print(f"{tn} is largest number among {fn},{sn} and {tn}")
