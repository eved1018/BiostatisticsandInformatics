import pandas as pd 
import plotly.express as px

# df = px.data.gapminder()
# fig = px.scatter(df, x="gdpPercap", y="lifeExp", animation_frame="year", animation_group="country",
#            size="pop", color="continent", hover_name="country",
#            log_x=True, size_max=55, range_x=[100,100000], range_y=[25,90])
# fig.show()

path = '/Users/evanedelstein/Desktop/Research_Evan/Raji_Summer2019_atom/Data_Files/CrossVal_logreg_RF/meta-ppisp/meta-pisp-test.csv'
frame = pd.read_csv(path)
frame = frame.drop(columns=['residue'])
frame = frame[["annotated","meta-ppisp"]]
print(frame)
frame.to_csv("/Users/evanedelstein/Desktop/data.csv", index=False)
