import requests
class read:
    with open( "user.txt", "r", encoding="utf-8") as file:
        all = file.readlines()
    user = all[0].strip('\n')
    password = all[1]
    print(user)
    print(password)
    yes = requests.post("http://10.21.1.70:801/eportal/portal/login?user_account=%2C0%2C"+user+"&user_password="+password)
    ##1是PC，0是手机
    print(yes)
