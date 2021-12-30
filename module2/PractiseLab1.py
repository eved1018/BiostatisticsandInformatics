import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def PractiseLab1_arbutnot():

    arbutnot_data = pd.read_csv("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/module2/arbuthnot.csv")
    arbutnot_data.columns.values[0] = 'X'


    girls_data = arbutnot_data["girls"]
    print("girls data\n", girls_data)

    boys_data = arbutnot_data[["X","year","boys"]]
    print("boys data\n",boys_data)

    children_data = arbutnot_data["boys"] + arbutnot_data["girls"]
    print("all children\n", children_data)

    ratio = arbutnot_data["boys"]/arbutnot_data["girls"]
    print("ratio of boys to girls\n",ratio)

    proportion_boys = arbutnot_data["boys"]/(arbutnot_data["girls"]+ arbutnot_data["boys"])
    print("prportion of boys to total children\n", proportion_boys)

    # add proportion boys as column 
    arbutnot_data['proportion_boys'] = proportion_boys
    # plot
    arbutnot_data.plot(x="year", y="proportion_boys", kind="line",c="red")
    plt.savefig("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/module2/arbutnot_data.png")
    plt.clf()
    return 


def PractiseLab1_present():
    present_data = pd.read_csv("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/module2/present.csv")

    print("data set\n", present_data)
    # this file contains a three column: years, boys, and girls. 
    # The boys and girls column makes up discrete data. 
    # The years in this data set range from 1940 to 2002.

    girls_data = present_data['girls']
    
    print("girls data \n",girls_data)

    boys_data = present_data['boys']
    print("boys data \n",boys_data)

    children_data = girls_data + boys_data
    print("children data \n",children_data)

    ratio = boys_data/girls_data
    print("ratio of boys to girls \n",ratio)

    proportion = boys_data/children_data
    print("proportion of boys to total children \n",proportion)

    # make new column with total children born
    present_data["children"] = present_data["boys"] + present_data["girls"]
    # find the index of the row with maximum births 
    max_birth_year = present_data.iloc[present_data["children"].idxmax()] 
    # display the year of maximum births
    print("max birth year is:", max_birth_year["year"])
    # 1961

    present_data.plot(x='year',y='children', kind='line')
    plt.savefig("/Users/evanedelstein/Desktop/School/2021/Spring2021/BTM-6000/module2/present_data.png")
    plt.clf()
    return 

PractiseLab1_arbutnot()
PractiseLab1_present()