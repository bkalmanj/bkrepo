#!/usr/bin/python3
import json
import sys


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
    
if __name__ == '__main__':
    obj = {'a': {'b': {'c': 'd'}}}
    value = key_extract(obj, 'c')
    print(value)