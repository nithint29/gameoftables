import requests, random
import numpy as np
import csv

data = []
for i in range(10):
    params = {"amount":500,"region":"germany"}
    new = requests.get("https://uinames.com/api",params).json()
    data.extend(new)

houses = ['Stark', 'Lannister', 'Targaryen', 'Martell', 'Bolton', 'Baratheon', 'Tyrell', 'Arryn', 'Greyjoy', 'Frey', 'None']
p = np.array([1,        2,          .5,         1.5,       .5,          1,         1.5,     .2,        .8,     1,       30   ])
p = p/np.sum(p)
print(np.sum(p))

db = open('db.txt','w')
csvwriter = csv.writer(db)
columns = list(data[0].keys())
columns.append("allegiance")
csvwriter.writerow(columns)

for l in range(0,len(data)):
    for key in data[l].keys():
        new_key = key.replace("region","RoyaltyScale")
        if new_key != key:
            data[l][new_key] = data[l][key]
            del data[l][key]        


#change last names
for i in range (0,len(data)):
    name = np.random.choice(houses, 1, p=p)[0]
    if(name != 'None'):
        data[i]['surname'] = name

#add royaltyscales
for k in range (0,len(data)):
    rand = random.randint(1,3)
    royalRand = random.randint(4,10)
    if(data[k]['surname'] in ['Lannister', 'Tyrell']):
        data[k]['RoyaltyScale'] = random.randint(royalRand, 10)
    elif(data[k]['surname'] == 'Targaryen'):
        data[k]['RoyaltyScale'] = random.randint(8, 10)
    elif data[k]['surname'] in houses:
        data[k]['RoyaltyScale'] = royalRand
    else:
        data[k]['RoyaltyScale'] = rand

    #add allegiance
    traitor_roll = random.randint(1,50)
    surname = data[k]['surname']
    if(surname in houses):
        if(traitor_roll >= 46 and surname != 'Stark'):
            data[k]['allegiance'] = np.random.choice(houses[0:-1], 1)[0]
        else:
            data[k]["allegiance"] = surname

    else:
        data[k]['allegiance'] = np.random.choice(houses[0:-1], 1, p=p[0:-1]/np.sum(p[0:-1]))[0]


    #write to csv file
    csvwriter.writerow(data[k].values())

db.close()

def isEnglish(s):
    try:
        s.encode(encoding='utf-8').decode('ascii')
    except UnicodeDecodeError:
        return False
    else:
        return True

print(data, len(data))





