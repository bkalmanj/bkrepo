#!/usr/bin/python3
import requests
import json
import sys
import os
args = sys.argv[1:]
resource_group = args[0] 
vm_name = args[1] 
if len(args) == 3:
    key = args[2]
else:
    key=[]
    
tenant_id = os.environ["tenant"]
client_id = os.environ["client"]
client_secret = os.environ["secret"]
resource_uri = 'https://management.azure.com'

token_url = 'https://login.microsoftonline.com/{0}/oauth2/token'.format(tenant_id)

def key_extract(obj, key):
    arr = []

    def extract(obj, arr, key):
        if isinstance(obj, dict):
            for k, v in obj.items():      
                if k == key and isinstance(v,(dict, list)):
                    arr.append(v)               
                elif isinstance(v, (dict, list)):
                    extract(v, arr, key)
                elif k == key:
                    arr.append(v)                    
        elif isinstance(obj, list):
            for item in obj:
                extract(item, arr, key)
        return arr

    values = extract(obj, arr, key)
    if isinstance(values, (dict, list)):
        return json.dumps(values,indent=4)
    else:
        return values

headers = {'Content-Type': 'application/x-www-form-urlencoded'}
payload = {'grant_type': 'client_credentials',
           'client_id': client_id,
           'client_secret': client_secret,
           'resource': resource_uri}


response = requests.post(token_url, headers=headers, data=payload)
access_token = response.json()['access_token']
headers = {'Authorization': 'Bearer {0}'.format(access_token)}
uri = 'https://management.azure.com/subscriptions/b5a5d863-e8d1-4068-ad0f-81ef984c6125/resourceGroups/{}/providers/Microsoft.Compute/virtualMachines/{}?api-version=2022-11-01'.format(resource_group,vm_name)
metadata = requests.get(uri, headers=headers)

if key:
    print(key_extract(metadata.json(),key))
else:
    jsonprint=json.dumps(metadata.json(),indent=4)
    print(jsonprint)