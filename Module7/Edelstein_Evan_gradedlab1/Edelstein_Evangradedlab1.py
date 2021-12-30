
import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
import sys
sys.path.insert(0, '/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Mods')
from Biostats import *
from numpy import sqrt
from matplotlib.backends.backend_pdf import PdfPages

# read dataset
df = pd.read_csv("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Module7/Module 7 - Graded Lab 1 - NHANES subset.csv")
# describe data 
df["SBP"].describe()
# IQR 
IQR(df, "SBP")

# Plot with three different amount  of bins 
with PdfPages("Module7/SBP_bins_hist.pdf") as pdf:
    for i in [10,20,30]:
        plt.figure()
        plt = hist_plot(df,"SBP",False,i)
        pdf.savefig()
plt.clf()


# compare stddev and staderrror of all SBP
std = np.std(df["SBP"])
SE = std / sqrt(1000)
print("std:",std)
print("Standard error:",SE)


# create three sets of 100 samples and output mean, stddev, sterror and histplt
with PdfPages("Module7/SBP_samples_hist.pdf") as pdf:
    for i in range(1,4):
        print("sample:",i)
        sample = df.sample(n=100)
        mean = np.mean(sample["SBP"])
        std = np.std(sample["SBP"])
        SE = std / sqrt(100)
        print("mean:",mean)
        print("std:",std)
        print("Standard error:",SE)
        plt.figure()
        fig = hist_plot(sample,"SBP",False,25)
        plt.tight_layout()
        pdf.savefig()
plt.clf()

# find range of 95th percentile 
df2 = df[df["SBP"] >=df["SBP"].quantile(.95)]
max = df2["SBP"].max()
min = df2["SBP"].min()
print(f"95th percentile is SBP values in range of range ({min},{max})")


