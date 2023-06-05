import requests
# f = open("nhl_height.csv","w")
j = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster" #hella nice API
json = requests.get(url=j)
data = json.json()

for team in data['teams']:
    for player in team['roster']['roster']:
        person = player["person"]
        playerid = person["id"]
        playerName = person["fullName"]

        purl = f"https://statsapi.web.nhl.com/api/v1/people/{playerid}"
        j = requests.get(url=purl)
        d = j.json()

        height = d["people"][0]['height']
        f.write(height + "," + playerName+"\n")
f.close()

