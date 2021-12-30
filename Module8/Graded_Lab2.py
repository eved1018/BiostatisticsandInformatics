import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
import sys
sys.path.insert(0, '/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Mods')
from Biostats import *
from numpy import fabs, sqrt
# read dataset
df = pd.read_csv("/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Module8/Module 8 - Graded Lab 2 - NHANES subset.csv")
df.head()

males = df[df["gender"] == 1]
females = df[df["gender"] == 2]

plt1 = hist_plot(males,"SBP",False,False)
plt1.show()
plt2 = hist_plot(females,"SBP",False,False)
plt2.show()
