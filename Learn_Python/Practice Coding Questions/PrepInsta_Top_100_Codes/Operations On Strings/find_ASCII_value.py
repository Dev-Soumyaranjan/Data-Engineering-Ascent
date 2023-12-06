from utils import get_character as gc


def getASCII_value(c):
    return ord(c)


if __name__ == '__main__':
    user_input = gc()
    result = getASCII_value(user_input)
    print(f'ASCII value of {user_input} is {result}')
