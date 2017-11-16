import requests, random
import numpy as np
import csv
import pickle
from unidecode import unidecode


houses = ['Stark', 'Lannister', 'Targaryen', 'Martell', 'Bolton', 'Baratheon', 'Tyrell', 'Arryn', 'Greyjoy', 'Frey', 'None']
p = np.array([1,        2,          .5,         1.5,       .5,          1,         1.5,     .2,        .8,     1,       30   ])
p = p/np.sum(p)
print(np.sum(p[:-1]))


#obtain data from api
def pullData(amount=500):
    regions = ["germany","slovakia","romania","france","italy","poland","finland","sweden","estonia","netherlands"]
    data = []
    for r in regions:
        print("batch: {}".format(r))
        params = {"amount":500,"region":r}
        new = requests.get("https://uinames.com/api",params).json()
        data.extend(new)

    #normalize the data:
    for d in data:
        for k in d.keys():
            d[k] = unidecode(d[k])

    return data


def createCharactersTable(input, filename="characters.txt"):
    data = input[:]
    #open csvwriter and txt
    char_table = open(filename,'w+')
    csvwriter = csv.writer(char_table)
    columns = ['charID','name','surname','gender','royaltyScale','main']
    csvwriter.writerow(columns)

    for l in range(0,len(data)):
        for key in data[l].keys():
            new_key = key.replace("region","RoyaltyScale")
            if new_key != key:
                data[l][new_key] = data[l][key]
                del data[l][key]

 #change last names and add character ID
    for i in range (0,len(data)):
        name = np.random.choice(houses, 1, p=p)[0]
        if(name != 'None'):
            data[i]['surname'] = name
        data[i]['charID'] = '{0:04d}'.format(i+1)
        data[i]['main'] = 'false'

    #add royaltyscales and age
    for k in range (0,len(data)):
        rand = random.randint(1,3)
        royalRand = random.randint(4,10)
        if(data[k]['surname'] in ['Lannister', 'Tyrell', 'Stark']):
            data[k]['RoyaltyScale'] = random.randint(royalRand, 10)
        elif(data[k]['surname'] == 'Targaryen'):
            data[k]['RoyaltyScale'] = random.randint(8, 10)
        elif data[k]['surname'] in houses:
            data[k]['RoyaltyScale'] = royalRand
        else:
            data[k]['RoyaltyScale'] = rand
        #write to csv file
        curr = data[k]
        csvwriter.writerow([curr['charID'], curr['name'], curr['surname'], curr['gender'], curr['RoyaltyScale'], curr['main']])

    char_table.close()
    return data

def createAllegianceTable(characters, filename="allegiances.txt"):
    data = characters
    table = open(filename,'w+')
    csvwriter = csv.writer(table)
    columns = ['charID', 'name','surname','allegiance']
    csvwriter.writerow(columns)

    for k in range(0, len(data)):
        #add allegiance
        traitor_roll = random.randint(1,50)
        surname = data[k]['surname']
        if(surname in houses):
            if(traitor_roll >= 47 and surname != 'Stark'):
                data[k]['allegiance'] = np.random.choice(houses[0:-1], 1)[0]
            else:
                data[k]["allegiance"] = surname

        else:
            data[k]['allegiance'] = np.random.choice(houses[0:-1], 1, p=p[0:-1]/np.sum(p[0:-1]))[0]

        curr = data[k]
        csvwriter.writerow(
            [curr['charID'], curr['name'], curr['surname'], curr['allegiance']])
    table.close()
    return data

def createRomances(characters, filename = 'romances.txt'):
    data = characters[:]
    table = open(filename, 'w+')
    csvwriter = csv.writer(table)
    columns = ['charID1', 'name1', 'surname1', 'charID2', 'name2', 'surname2']
    csvwriter.writerow(columns)

    size = len(data)
    roms = [{}]*size
    i = 0
    while(i<2000):
        randNum = random.randint(0, size-1)
        if (data[randNum]['surname'] == data[i]['surname']) and (
                data[randNum]['surname'] != 'Lannister' or data[randNum]['surname'] != 'Targaryen'):
            i = i - 1
            continue
        data[i]['name2'] = data[random.randint(0, size-1)]['name']
        data[i]['surname2'] = data[random.randint(0, size-1)]['surname']

    for i in range(0, len(data)):
        if 'region' in data[i]: del data[i]['region']
        if 'gender' in data[i]: del data[i]['gender']
    print(data)

    i+=1




def isEnglish(s):
    try:
        s.encode(encoding='utf-8').decode('ascii')
    except UnicodeDecodeError:
        return False
    else:
        return True


if(__name__ == '__main__'):
    # rawdata = pullData()
    # pickle.dump(rawdata, open('rawdata.pkl', 'wb'))

    rawdata = pickle.load(open('rawdata.pkl','rb'))

    chars = createCharactersTable(rawdata)
    data = createAllegianceTable(chars)








