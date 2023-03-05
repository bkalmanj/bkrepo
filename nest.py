
import json
import sys
args = sys.argv[1:]
json_file = args[0]
key_json = args[1] 

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
    

with open(json_file) as f:
   obj = json.load(f)
value = key_extract(obj, key_json)
print(value)
