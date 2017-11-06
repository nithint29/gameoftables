import urllib.request, json, pandas as pd, random
with urllib.request.urlopen("https://uinames.com/api/?amount=500") as url:
    data = json.loads(url.read().decode())

with urllib.request.urlopen("https://uinames.com/api/?amount=500") as url2:
    data2 = json.loads(url2.read().decode())

for i in range (0,len(data)):
    randNum = random.randint(1,10)
    if randNum == 1 or randNum == 3 or randNum == 4:
        data[i]['surname'] = 'Lannister'
    if randNum == 2:
        data[i]['surname'] = 'Stark'
    if randNum == 5:
        data[i]['surname'] = 'Tyrell'

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
