from utils import get_character as gc


def isalphabet(c):
    return (65 <= ord(c) <= 90) or (97 <= ord(c) <= 122)


if __name__ == '__main__':
    user_input = gc()
    if isalphabet(user_input):
        print("This is an alphabet")
    else:
        print("This is not an alphabet")


"""
   Alternative way:(using isalpha()
   
   if user_input.isalpha():
            print("This is an alphabet")
   else:
        print("This is not an alphabet")
"""