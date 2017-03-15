# Matthews Cipher - r = 4
def Matthews(n, key):
    x = [key]
    r = 4
    for i in range(n - 1):
        x.append((1 + r) * (1 + (1 / r)) * x[i] * ((1 - x[i]) ** r))
    return x


#Reads File from Args - Encrypts input with cipher and outputs cipher text
def ENCRYPT(key):
    plaintext = open(str(sys.argv[1])).read() #Readfile
    stream = Matthews(len(plaintext),key) #Compute Mathews Cipher on line
    e = open(str(sys.argv[2]), w )
    e.write(stream)
    e.close()

def DECRYPT(key):
    ciphertext = open(str(sys.argv[1])).read() #Read File
    stream = MATTHEWS(len(ciphertext),key) #Cipher
    plaintext = Decipher(ciphertext,stream)
    e = open(str(sys.argv[2]), w ) #Write to Fule
    e.write(plaintext)
    e.close()

def Decipher(ciphertext,stream):
    x=[]
    for i in range(len(ciphertext)):
        info = int(ciphertext[i],2)
        confusion = int(stream[i]) #noise
        x.append(bin(info-confusion)) #remove cipher from cipher text
    return x

def ENCRYPT_DECRYPT(key,option):
    if (option):
        ENCRYPT(key)
    else:
        DECRYPT(key)
    if ((len(sys.argv)==5) and (str(sys.argv[1])=="-e")):
        ENCRYPT_DECRYPT(float(sys.argv[2]),True)
    elif ((len(sys.argv)==5) and (str(sys.argv[1])=="-d")):
        ENCRYPT_DECRYPT(float(sys.argv[2]),False)
    else:
        print ("Error")
