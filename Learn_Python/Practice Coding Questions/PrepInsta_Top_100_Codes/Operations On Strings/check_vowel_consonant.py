from utils import get_character as gc


def isvowel(c):
    return c == 'a' or c == 'e' or c == 'i' or c == 'o' or c == 'u'


if __name__ == '__main__':
    my_input = gc()
    if isvowel(my_input):
        print(f"{my_input} is a vowel")
    else:
        print(f'{my_input} is a consonant')
