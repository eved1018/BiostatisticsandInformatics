import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import sem
# import nhanes
# from nhanes.load import load_NHANES_data, load_NHANES_metadata
from scipy.stats import binom
from statistics import NormalDist


def scatter(df,x,y): # x,y are col names 
    df.plot.scatter(x=x,y=y)
    plt.tight_layout()
    plt.style.use('fivethirtyeight')
    return plt

def hist_plot(X,col_name,path,bin):
    if bin == False: 
        hist = X.hist(column=col_name, edgecolor='black',color="gray")
    else:
        hist = X.hist(column=col_name, edgecolor='black',color="gray",bins=bin)
    std = np.std(X[f"{col_name}"])
    mean = np.mean(X[f"{col_name}"])
    plt.xlabel("{}".format(col_name))
    plt.ylabel("Frequency")
    plt.title("{} distribution\nBins:{}".format(col_name,bin))
    plt.tight_layout()
    plt.style.use('fivethirtyeight')
    min = X[col_name].min()
    max = X[col_name].max()
    plt.xlim([min, max])
    min_ylim, max_ylim = plt.ylim()
    plt.axvline(mean, color='k', linestyle='dashed', linewidth=1)
    plt.text(mean*1.1, max_ylim*0.9, 'Mean: {:.2f}'.format(mean))
    # for i in range(1,4):
    #     colors = ["#0000FF","#ff8333","#008000","#FF00FF"]
    #     s1 = mean + std * i
    #     s2 = mean - std * i 
    #     plt.axvline(s1, color=colors[i])
    #     plt.axvline(s2, color=colors[i])
    s1 = mean + std
    s2 = mean - std 
    plt.axvline(s1, color="red",linestyle='dashed', linewidth=1)
    plt.axvline(s2, color="red",linestyle='dashed', linewidth=1)
    if path is False:
        return plt
    else:
        plt.savefig(path)
        plt.clf()

def dbinom(x,size,prob):
    result=binom.pmf(k=x,n=size,p=prob,loc=0)
    return result

def pbinom(q,size,prob):
    result=binom.cdf(k=q,n=size,p=prob,loc=0)
    return result

def CLT_stats(df,col):
    mean = df[col].mean()
    median =df[col].median()
    mode =df[col].mode()[0]
    stdev = df[col].std()
    print("mean: {} \nmedian: {} \nmode: {} \nSTDEV: {}\n".format(mean,median,mode,stdev))
    

def Strata(df, col):
    Q4 = df[col].min()
    Q3 = df[col].quantile(0.25)
    Q2 = df[col].quantile(0.5)
    Q1 = df[col].quantile(0.75)
    Q1I = df[df[col] > Q1]
    Q2I = df[(df[col] > Q2) & (df[col] < Q1)]
    Q3I = df[(df[col] > Q3) & (df[col] < Q2)]
    Q4I = df[(df[col] > Q4) & (df[col] < Q3)]

    frames = {
        "Q1 Interval" : Q1I,
        "Q2 Interval" : Q2I,
        "Q3 Interval" : Q3I,
        "Q4 Interval": Q4I
    }
    for i in frames:
        print("{} observations:".format(i),len(frames[i]) )
        mean = frames[i][col].mean()
        print("{} mean:{}".format(i, mean))

def IQR(X,col: str):
    col = str(col)
    # IQR for col 
    Q1 = X[f"{col}"].quantile(0.25)
    Q3 = X[f"{col}"].quantile(0.75)
    IQR = Q3 - Q1
    print("IQR:",IQR)
    

def confidence_interval(data, confidence=0.95):
  dist = NormalDist.from_samples(data)
  z = NormalDist().inv_cdf((1 + confidence) / 2.)
  h = dist.stdev * z / ((len(data) - 1) ** .5)
  return dist.mean - h, dist.mean + h