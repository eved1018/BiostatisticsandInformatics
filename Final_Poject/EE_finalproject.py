
#%%
import pandas as pd 
from scipy import stats
import matplotlib.pyplot as plt
import nhanes
from nhanes.load import load_NHANES_data
import statsmodels.api as sm


df = load_NHANES_data()
vars = df.columns.tolist()
print(vars)
df = df[df['GeneralHealthCondition'].notna()]
df = df[df['HowOftenFeelOverlySleepyDuringDay'].notna()]
options = df["HowOftenFeelOverlySleepyDuringDay"] .unique()
options
# df = df[df['GeneralHealthCondition'].notna()]
# df["healthy"] = [0 if i != "poor" else 1 for i in df["GeneralHealthCondition"]]
# train = df.sample(n = 1000)
# Xtraim = train[['', '', '']]
# ytrain = train[['healthy']]
# log_reg = sm.Logit(ytrain, Xtrain).fit()
# %%
