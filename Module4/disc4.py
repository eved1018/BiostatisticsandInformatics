from gazpacho import get
from gazpacho import Soup
import pandas as pd
import time

position = 'F'

base = f'https://www.cbssports.com/fantasy/hockey/stats'
url = f'{base}/{position}/2019/restofseason/projections/'
html = get(url)
soup = Soup(html)
# HTML: <tr class="TableBase-bodyTr ">
rows = soup.find('tr', {'class': 'TableBase-bodyTr '})
row = rows[0]
print(row)