import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binom
from scipy.stats import norm


# prob of rolling a 6 ona die = 1/6
# prob of rolling 3 consecutive 6's is (1/6)^3 = 1/216
# prob of rolling a 6, a 1 and a 6 again i s also 1/216
# 
# Continuous -> numerical data in which can take on any value within a range -> examples include height and weight 
# Categorical -> data that devides the sample into groups -> examples include on/off or sick/health
# Discrete -> data that can take on quantized or specific amounts -> examples include population counts and goals scored in hockey
# 
def dbinom(x,size,prob):
    result=binom.pmf(k=x,n=size,p=prob,loc=0)
    return result

def pbinom(q,size,prob):
    result=binom.cdf(k=q,n=size,p=prob,loc=0)
    return result

print("Q3")
BMI_data = pd.read_csv("Module4/Module 4 - BMI.csv") 
hist = BMI_data.hist(column="BMI", edgecolor='black',color="gray",bins=15)
plt.xlabel("BMI")
plt.ylabel("Frequency")
plt.title("BMI distribution")
plt.tight_layout
mean = np.mean(BMI_data["BMI"])
print("mean: {}".format(mean))
print("index points")
std = np.std(BMI_data["BMI"])
BMI_data["Z_score"] = (BMI_data["BMI"] - mean)/ std
print(BMI_data.head())
for i in range(1,4):
    colors = ["#0000FF","#ff8333","#008000","#FF00FF"]
    s1 = mean + std * i
    s2 = mean - std * i 
    print("{} std is {} and {}".format(i,s1,s2))
    plt.axvline(s1, color=colors[i])
    plt.axvline(s2, color=colors[i])
    result_plus=norm.cdf(s1,mean,std)
    result_minus=norm.cdf(s2,mean,std)
    print("pnorm difference: {}".format(result_plus-result_minus))

plt.savefig("Module4/practiselab4.png")
plt.clf()


# Q4
print("Q4")

#Q4ai
print(dbinom(3,4,0.1))
#Q4aii
print(dbinom(4,12,0.2))
#Q4aiii
print(dbinom(3,15,0.3))
#Q4aiv
print(pbinom(3,15,0.3))