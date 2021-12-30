# import pandas as pd 
import sys
sys.path.insert(0, '/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Mods')
from Biostats import *



# load and view data set
ames_data = pd.read_csv("http://www.openintro.org/stat/data/ames.csv")
# print(ames_data)
# mean,median and mode lot area
print("Lot Area")
CLT_stats(ames_data,"Gr.Liv.Area")

# random sample of 60 observations 
print("60 samples")
sample_60 = ames_data.sample(n=60)
CLT_stats(sample_60,"Gr.Liv.Area")

# sample 120
sample_120 = ames_data.sample(n=120)
print("120 samples")
CLT_stats(sample_120,"Gr.Liv.Area")
means = []
for i in range(0,500):
    sample = ames_data.sample(n=60)
    mean = sample["Gr.Liv.Area"].mean()
    means.append(mean)

print("Lot Area mean distribution",np.mean(means),"\n")

# more samples and larger samples -> more accurate estimation of population mean


plt.hist(means,edgecolor='black',color="gray")
plt.tight_layout
plt.style.use('fivethirtyeight')
plt.xlabel("mean")
plt.ylabel("freq")
plt.show()

# SalePrice
print("sales price")
mean_total = ames_data["SalePrice"].mean()
print("mean price:",mean_total)
sample_50 = ames_data.sample(n=50)
mean_50  = sample_50["SalePrice"].mean()
print("sample 50 mean:",mean_50)
means = []
for i in range(1,5000):
    sample = ames_data.sample(n=60)
    mean = sample["SalePrice"].mean()
    means.append(mean)

print("Price mean distribution",np.mean(means),"\n")

Q4 = ames_data['SalePrice'].min()
Q3 = ames_data['SalePrice'].quantile(0.25)
Q2 = ames_data['SalePrice'].quantile(0.5)
Q1 = ames_data['SalePrice'].quantile(0.75)
max  = ames_data['SalePrice'].max()

Q1I = ames_data[ames_data["SalePrice"] > Q1]
Q2I = ames_data[(ames_data["SalePrice"] > Q2) & (ames_data["SalePrice"] < Q1)]
Q3I = ames_data[(ames_data["SalePrice"] > Q3) & (ames_data["SalePrice"] < Q2)]
Q4I = ames_data[(ames_data["SalePrice"] > Q4) & (ames_data["SalePrice"] < Q3)]

frames = {
    "Q1 Interval" : Q1I,
    "Q2 Interval" : Q2I,
    "Q3 Interval" : Q3I,
    "Q4 Interval": Q4I
}
for i in frames:
    print("{} observations:".format(i),len(frames[i]) )
    mean = frames[i]['SalePrice'].mean()
    print("{} mean:{}".format(i, mean))


