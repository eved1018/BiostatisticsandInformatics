import sys
sys.path.insert(0, '/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Mods')
from Biostats import *
from sklearn.metrics import roc_curve
from sklearn.metrics import roc_auc_score


# df = pd.read_csv("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/Module6/Module 6 - NHANES subset.csv")
# print(df.head())
# # stage_1 =  df[(df["eGFR"] >= 90) & (df[]) ]
# stage_1 =  df[(df["eGFR"] >= 90) ]
# stage_2 =  df[(df["eGFR"] < 90) & (df["eGFR"] >= 60) ]
# stage_3=  df[(df["eGFR"] < 60) & (df["eGFR"] >= 30) ]
# stage_4 =  df[(df["eGFR"] < 30) & (df["eGFR"] >= 15) ]
# stage_1 =  df[df["eGFR"] < 15 ]

# def plot_roc_curve(fpr, tpr):
#     plt.plot(fpr, tpr, color='orange', label='ROC')
#     plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
#     plt.xlabel('False Positive Rate')
#     plt.ylabel('True Positive Rate')
#     plt.title('Receiver Operating Characteristic (ROC) Curve')
#     plt.legend()
#     plt.show()


# print(dbinom(1,.13,11))


print(pbinom(1,11,0.13))