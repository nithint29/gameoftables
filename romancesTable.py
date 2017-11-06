import urllib.request, json, random, numpy as np
import urllib
with urllib.request.urlopen("https://uinames.com/api/?amount=500&region=germany") as url:
    data = json.loads(url.read().decode())

with urllib.request.urlopen("https://uinames.com/api/?amount=500&region=germany") as url2:
    data2 = json.loads(url2.read().decode())

houses = ['Stark', 'Lannister', 'Targaryen', 'Martell', 'Bolton', 'Baratheon', 'Tyrell', 'Arryn', 'Greyjoy', 'Frey', 'None']
p = np.array([1,        2,          .5,         1.5,       .5,          1,         1.5,     .2,        .8,     1,       10  ])
p = p/np.sum(p)

for i in range (0,len(data)):
    name = np.random.choice(houses, 1, p=p)[0]
    if(name != 'None'):
        data[i]['surname'] = name

for i in range(0,len(data)):
    randNum = random.randint(0,499)
    if (data[randNum]['surname'] == data[i]['surname']) and (data[randNum]['surname'] != 'Lannister' or data[randNum]['surname'] != 'Targaryen'): 
        i = i-1
        continue
    data[i]['name2'] = data[random.randint(0,499)]['name']
    data[i]['surname2'] = data[random.randint(0,499)]['surname']

for i in range(0,len(data)):
    if 'region' in data[i]: del data[i]['region']
    if 'gender' in data[i]: del data[i]['gender']
print(data)
