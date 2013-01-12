#!/usr/bin/env python
# cointoss.py

import sys, random

def main():
    if len(sys.argv) != 2:
        print "Usage: ./cointoss.py <iterations>"
        sys.exit(1)

    i = int(sys.argv[1])
    count = heads = tails = 0

    while count < i:
        if random.randint(0, 1) == 0: heads += 1
        else: tails += 1
        count += 1

    print "Heads: %d  Tails: %d" % (heads, tails)

    if heads > tails: print "Heads won!\n"
    else: print "Tails won!\n"

    sys.exit(0)

if __name__ == '__main__':
    main()

