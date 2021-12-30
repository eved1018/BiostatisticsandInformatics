import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import sem

plt.style.use('fivethirtyeight')
# load data set 
cdc_data = pd.read_csv("http://www.openintro.org/stat/data/cdc.csv")
# show first few lines of data set
print(cdc_data.head())

# show shape of frame, same as "dim"
print("shape:",cdc_data.shape)

# summary statistics
print(cdc_data.describe())

# this data set contains health information related to 20000 individuals.
# the variables involved in the dataset are:
#  general health, health plan, exercise habbits, smoking habbit, height, weight, desired weight, age and gender
# the exercise, healthplan , smoking habbit and gender are boolean variables. 
# height, weight and age are nominal data 


# number of males
males = len(cdc_data[cdc_data['gender'] == 'm'])
print("number of males:",males)
# 9569 males

# number of females 
females = len(cdc_data[cdc_data['gender'] == 'f'])
print("number of females:",females)
# 10431 females

# number older than 25
# "len" functions returns teh length of a list
# "dataframe[lambda]" creates a list from function lambda iterated over dataframe (or in this case column of DF)
older_25 = len(cdc_data[cdc_data['age'] > 25])
print("number older than 25:",older_25)
# 17272 older than 25

# number older than 35
older_35 = len(cdc_data[cdc_data['age'] > 35])
print("number older than 35:",older_35)
# 13216 older than 35

# Histogram plot for age 
hist = cdc_data.hist(column="age",bins=25, edgecolor='black')
plt.xlabel("age")
plt.ylabel("Frequency")
plt.title("Age distribution")
plt.tight_layout
plt.show()


# mean, median and mode of age 
mean = cdc_data["age"].mean()
print("mean age:", mean)
median = cdc_data["age"].median()
print("median age:", median)
mode = cdc_data["age"].mode()
print("mode age:", mode)

# Stdev, variance and standard error
stdev = cdc_data["age"].std()
variance = cdc_data["age"].var()
print("stdev:", stdev)
print("variance:", variance)
print("standard error (SEM)",sem(cdc_data["age"]))

# IQR for age
Q1 = cdc_data['age'].quantile(0.25)
Q3 = cdc_data['age'].quantile(0.75)
IQR = Q3 - Q1
print("IQR:",IQR)

#  boxplot for age 
box = cdc_data.boxplot(column="age")
plt.xlabel("age")
plt.ylabel("Frequency")
plt.title("Age distribution")
plt.show()


# calculate BMI
weight = cdc_data['weight']/2.2
height = cdc_data['height']*2.5
height = height/100
height_squered = height ** 2
BMI = weight/(height_squered)
cdc_data['BMI']= BMI
print("BMI data:",cdc_data.head())

# Male BMI
print("BMI data for men:\n",cdc_data[cdc_data['gender'] == 'm'].describe())
# BMI historgam
cdc_data_men = cdc_data[cdc_data['gender'] == 'm']
hist = cdc_data_men.hist(column="BMI")
plt.xlabel("BMI")
plt.ylabel("Frequency")
plt.title("BMI distribution: Men")
plt.show()

# Female BMI
print("BMI data for woman:\n", cdc_data[cdc_data['gender'] == 'f'].describe())
cdc_data_women = cdc_data[cdc_data['gender'] == 'f']
# Histogram
hist = cdc_data_women.hist(column="BMI")
plt.xlabel("BMI")
plt.ylabel("Frequency")
plt.title("BMI distribution: Woman")
plt.show()

# comapring mean BMI for men and woman 
print("mean BMI for men:",cdc_data_men["BMI"].mean())
print("mean BMI for woman:",cdc_data_women['BMI'].mean())



