from utils import getstring as take_string


def toggling_character(input_string):
    toggle_string = ''
    for c in input_string:
        if c.isupper():
            toggle_string = toggle_string + c.lower()
        else:
            toggle_string = toggle_string + c.upper()

    return toggle_string


if __name__ == '__main__':
    take_input = take_string()
    result = toggling_character(take_input)
    print(f'After toggle: {result}')
