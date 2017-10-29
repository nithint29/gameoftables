import urllib.request, json, pandas as pd, random
with urllib.request.urlopen("https://uinames.com/api/?amount=500") as url:
    data = json.loads(url.read().decode())

def isEnglish(s):
    try:
        s.encode(encoding='utf-8').decode('ascii')
    except UnicodeDecodeError:
        return False
    else:
        return True


for l in range(0,len(data)):
    for key in data[l].keys():
        new_key = key.replace("region","RoyaltyScale")
        if new_key != key:
            data[l][new_key] = data[l][key]
            del data[l][key]        


    
for i in range (0,len(data)):
    randNum = random.randint(1,10)
    if randNum == 1 or randNum == 3 or randNum == 4:
        data[i]['surname'] = 'Lannister'
    if randNum == 2:
        data[i]['surname'] = 'Stark'
    if randNum == 5:
        data[i]['surname'] = 'Tyrell'

for k in range (0,len(data)):
    rand = random.randint(1,6)
    royalRand = random.randint(7,10)
    if data[k]['surname'] == 'Lannister' or data[k]['surname'] == 'Stark' or data[k]['surname'] == 'Tyrell':
        data[k]['RoyaltyScale'] = royalRand            
    else:
        data[k]['RoyaltyScale'] = rand       

print(data)





