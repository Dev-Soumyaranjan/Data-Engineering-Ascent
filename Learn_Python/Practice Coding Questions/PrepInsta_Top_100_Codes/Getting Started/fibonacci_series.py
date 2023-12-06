from utils import print_list_values as pl


def return_fibonacci_series(t):
    prev = 0
    curr = 1
    if t == 1:
        return prev
    elif t == 2:
        return prev, curr
    else:
        fs = [prev, curr]
        while t > 2:
            nxt = prev + curr
            fs.append(nxt)
            prev = curr
            curr = nxt
            t -= 1
        return fs


if __name__ == '__main__':
    term = int(input('Enter term upto which you want to print fibonacci series: '))
    pl(return_fibonacci_series(term))
