import sys
sys.path.insert(0, '/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Mods')
from Biostats import *
for i in range(0,25):
    print(i)
    print(dbinom(i,25,.66))
