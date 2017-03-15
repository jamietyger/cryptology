def BlumBlum(Key,BI,N)

    cipher = []

    x=Key

    for i in range(1,N):

        x = x**2

        cipher.append(x%BI)

    return cipher
