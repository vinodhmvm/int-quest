#!/usr/bin/env python3
#Import functions
from __future__ import print_function
import json

#Finding the key in json metadata file
def findkeyvalue(id, json_file):
    output = []
    def decode_json(dict):
        try:
            output.append(dict[id])
        except KeyError:
            pass
        return dict

    json.loads(json_file, object_hook=decode_json)
    return output

#Read JSON data from file
with open('./instancemetadata.json', 'r') as file:
    json_file = file.read() #Read JSON output from file

#Read Input
Key = input("Enter the key: ")
print(findkeyvalue(Key, json_file))