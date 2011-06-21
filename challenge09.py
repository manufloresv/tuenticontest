# Challenge 9: Christmas lights - Tuenti Programming Contest
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: python2 challenge09.py or python3 challenge09.py

def lamps(t, l):
    output = [str(x) for x in range((t+1)%2, min(t, l), 2)]
    return " ".join(output) if output else "All lights are off :("

n=int(input())
for i in range(n):
    l=int(input())
    t=int(input())
    print(lamps(t, l))
