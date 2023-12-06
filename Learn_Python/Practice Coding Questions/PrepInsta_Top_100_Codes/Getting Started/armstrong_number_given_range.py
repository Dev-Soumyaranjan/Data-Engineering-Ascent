from utils import take_range as tr
from check_armstrong_number import isArmstrong
from utils import print_list_values

if __name__ == '__main__':
    range1, range2 = tr()
    # all the armstrong numbers will be stored in armstrongNumber list
    armstrongNumber = []
    # It will iterate till the end range
    for n in range(range1, range2 + 1):
        # Calling isArmstrong() function to check whether the number is an armstrong number or not. If the number is
        # armstrong number, then it will get append to the armstrongNumber list
        if isArmstrong(n):
            armstrongNumber.append(n)
    # Calling print_list_values() function to print all the elements which are stored inside armstrongNumber list
    print_list_values(armstrongNumber)
