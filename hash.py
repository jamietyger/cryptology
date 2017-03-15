import random

def Hash(PIN):

    a = random.randrange(2**16)  # x^a

    b = random.randrange(2**16)  # bx

    c = random.randrange(2**16)  # c

    prime = 2**32 - 1

    offshoot = 1234

    if (0 < PIN < 9999):

        PIN = ((PIN**a) + (PIN * b) + c) % prime  # Quadratic Function

        key = ((prime * PIN) + offshoot)

        key = key % 2**16

        return key

    return 0

print Hash(1234)
