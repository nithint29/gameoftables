import requests, random
import numpy as np
import csv
import pickle
from unidecode import unidecode


houses = ['Stark', 'Lannister', 'Targaryen', 'Martell', 'Bolton', 'Baratheon', 'Tyrell', 'Arryn', 'Greyjoy', 'Frey', 'None']
p = np.array([1,        2,          .5,         1.5,       .5,          1,         1.5,     .2,        .8,     1,       30   ])
combatAbility = {'Stark':80, 'Lannister':45, 'Targaryen':85, 'Martell':60, 'Bolton':25,
                'Baratheon':70, 'Tyrell':30, 'Arryn':60, 'Greyjoy':40, 'Frey':15}
p = p/np.sum(p)
print(np.sum(p[:-1]))
targs = []


#obtain data from api
def pullData(amount=1):
    regions = ["germany","slovakia","romania","france","italy","poland","finland","sweden","estonia","netherlands"]
    data = []
    for r in regions:
        for i in range(amount):
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
        data[i]['charID'] = '{0:04d}'.format(i)
        data[i]['main'] = 'false'

    #add royaltyscales
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

def createRomances(characters, filename = 'romances.txt', num=2500):
    data = characters[:]
    table = open(filename, 'w+')
    csvwriter = csv.writer(table)
    columns = ['charID1', 'name1', 'surname1', 'charID2', 'name2', 'surname2']
    csvwriter.writerow(columns)


    for i in data:
        if i['surname'] == 'Targaryen':
            targs.append(i)

    size = len(data)
    roms = []
    i = 0
    while(len(roms)<num):
        print(len(roms))
        randNum1 = random.randint(0, size-1)
        randNum2 = random.randint(0, size-1)
        person1 = data[randNum1]
        person2 = data[randNum2]
        d = {}

        targRoll = random.randint(1, 100)
        if (person1['surname'] != 'Targaryen' and person2['surname'] == 'Targaryen' and targRoll<=40):
            randTarg = targs[random.randint(1, len(targs) - 1)]
            while(randTarg['charID'] == person2['charID']):
                randTarg = targs[random.randint(1, len(targs) - 1)]
            person1 = randTarg


        d['charID1'], d['name1'], d['surname1']= person1['charID'], person1['name'], person1['surname']

        if(person1['charID'] == person2['charID'] or
               (person1['surname'] == person2['surname'] and (person1['surname'] != 'Lannister' and person1['surname'] !='Targaryen') ) ):
            i-=1
            continue

        sameGenRoll = random.randint(1,100)
        if(person1['gender'] == person2['gender']):
            if(sameGenRoll<=90):
                i-=1
                continue

        otherHouseRoll = random.randint(1,100)
        if(person2['surname'] != person1['surname'] and person2['surname'] in houses and person1['surname'] in houses):
            if(otherHouseRoll<=50):
                i-=1
                continue

        targRoll = random.randint(1, 100)
        if(person2['surname'] != 'Targaryen' and person1['surname'] == 'Targaryen' and targRoll<=50):
            randTarg = targs[random.randint(1,len(targs)-1)]
            person2 = randTarg


        d['charID2'] = person2['charID']
        d['name2'] = person2['name']
        d['surname2'] = person2['surname']
        roms.append(d)

        csvwriter.writerow([d['charID1'], d['name1'], d['surname1'], d['charID2'], d['name2'], d['surname2']])
        i+=1
    table.close()
    return roms



def isEnglish(s):
    try:
        s.encode(encoding='utf-8').decode('ascii')
    except UnicodeDecodeError:
        return False
    else:
        return True


#should return all dead people
def createKills(allegiance, filename = 'kills.txt'):
    data = allegiance[:]
    print('in kills')

    columns = ['charID1', 'name1', 'surname1', 'charID2', 'name2', 'surname2']

    size = len(data)
    kills = []
    dead = []
    i = 0

    randNum2 = random.randint(0, size - 1)
    victim = data[randNum2]
    hero = None

    while(len(dead)<2500):
        print(i, len(dead))
        randNum1 = random.randint(0, size-1)
        killer = data[randNum1]
        if(hero != None):
            killer = hero

        while (victim['charID'] in dead):
            randNum2 = random.randint(0, size - 1)
            victim = data[randNum2]
        d = {}
        d['killerID'], d['killerName'], d['killerSurname']= killer['charID'], killer['name'], killer['surname']

        underdogRoll = random.randint(1,100)
        if(killer['surname'] not in houses and victim['surname'] in houses):
            if(underdogRoll<= 60):
                i-=1
                continue

        allyRoll = random.randint(1,100)
        if(killer['allegiance'] == victim['allegiance']):
            if (allyRoll <= 95):
                i -= 1
                continue

        heroRoll = random.randint(1,100)
        if(heroRoll <= combatAbility.get(killer['surname'], 10)):
            hero = killer
        else:
            hero = None

        d['victimID'] =victim['charID']
        d['victimName'] = victim['name']
        d['victimSurname'] = victim['surname']
        kills.append(d)
        dead.append(victim['charID'])


        writeTable(kills, ['killerID','killerName','killerSurname','victimID','victimName','victimSurname'], filename)

        i+=1

    return kills

#reads a table from text file as a dict
def readFromText(filename):
    file = open(filename, 'r')
    lines = file.readlines()

    d = {}
    titles = lines[0][0:-1].split(',')
    for col in titles:
        d[col] = 0

    data = []
    for line in lines[1:]:
        line = line[0:-1]
        colData = line.split(',')

        if(len(colData)>1):
            for i,key in enumerate(titles):
                d = d.copy()
                d[key] = colData[i]
            data.append(d)

    file.close()
    return data


#writes a table to csv (only the columns listed in titles)
def writeTable(data, titles, filename):
    table = open(filename, 'w+')
    csvwriter = csv.writer(table)
    csvwriter.writerow(titles)

    for d in data:
        line = [d[i] for i in titles]
        csvwriter.writerow(line)
    table.close()



if(__name__ == '__main__'):
    # rawdata = pullData(1)
    # pickle.dump(rawdata, open('rawdata.pkl', 'wb'))

    rawdata = pickle.load(open('rawdata.pkl','rb'))
    print(rawdata)
    #
    # chars = createCharactersTable(rawdata)
    # # chars = readFromText('characters.txt')
    # allies = createAllegianceTable(chars)
    # roms = createRomances(chars)
    # kills = createKills(allies)

    # writeTable(roms, ['charID1', 'charID2'], 'new.txt')









