from utils import take_user_input_int as ui


# Returns True if the given number is a prime number, False otherwise.
def isPrime(n):
    check_flag = True
    # If the number is 1 then it will set check_flag as False because 1 is not a prime number
    if n == 1:
        check_flag = False
    else:
        #  Iteration will continue until i value is (number/2) because we know after half of the number there will
        #  be no number remain which will divide number itself.
        for i in range(2, int((n + 1) / 2)+1):
            # So now if any value of i divides the original number(n), then check_flag value will set to false and loop
            # will be break.The reason is now the factors of number has increased from 2 to 3 which clearly indicate
            # the given number is not a prime number.
            if n % i == 0:
                check_flag = False

    return check_flag


if __name__ == '__main__':
    num = ui()

    # Store the return value of isPrime() function
    result = isPrime(num)
    # If result is True (means number is a prime number) then if block is executed otherwise else
    if result:
        print(f'{num} is a prime number.')
    else:
        print(f'{num} is not a prime number.')
