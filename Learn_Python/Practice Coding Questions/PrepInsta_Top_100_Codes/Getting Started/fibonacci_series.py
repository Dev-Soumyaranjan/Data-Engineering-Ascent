from utils import print_list_values as pl

def return_fibonacci_series(t):
    # Initialize variables to store the previous and current Fibonacci numbers
    prev = 0
    curr = 1

    # Check if the specified term is 1
    if t == 1:
        # If yes, return the first Fibonacci number
        return prev
    # Check if the specified term is 2
    elif t == 2:
        # If yes, return the first two Fibonacci numbers
        return prev, curr
    else:
        # If the term is greater than 2, initialize a list with the first two Fibonacci numbers
        fs = [prev, curr]

        # Use a loop to generate the Fibonacci series up to the specified term
        while t > 2:
            # Calculate the next Fibonacci number by adding the previous two numbers
            nxt = prev + curr
            # Append the next Fibonacci number to the list
            fs.append(nxt)
            # Update the previous and current Fibonacci numbers for the next iteration
            prev = curr
            curr = nxt
            # Decrement the term counter
            t -= 1

        # Return the generated Fibonacci series as a list
        return fs

# Check if the script is being run as the main program
if __name__ == '__main__':
    # Prompt the user to enter the term up to which they want to print the Fibonacci series
    term = int(input('Enter term up to which you want to print Fibonacci series: '))
    # Call the print_list_values function to print the generated Fibonacci series efficiently
    pl(return_fibonacci_series(term))
