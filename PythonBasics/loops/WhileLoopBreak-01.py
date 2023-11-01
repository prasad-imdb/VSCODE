# import random module
import random

i = 1

while i <= 20:
    newRand = random.randint(0,20)
    
    print(newRand)

    if newRand == 6:
        print("BREAK")
        break

    i += 1
