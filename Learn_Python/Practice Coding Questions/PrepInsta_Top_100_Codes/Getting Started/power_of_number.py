def calculate_power(b, p):
    """It will return the power of the given number"""

    # Initialize the result with 1
    result = 1
    # Iterate over the range of 0 to p.
    for _ in range(0, p):
        # Multiply the result by b to update the result to be the current power of b.
        result = result * b
    # Return result
    return result


if __name__ == '__main__':
    base = int(input('Enter base: '))
    power = int(input('Enter power: '))
    calculation = calculate_power(base, power)
    print(f'{power} raised to the power {base} is {calculation}')
