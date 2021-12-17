#!/usr/bin/env python3
#Import functions
from __future__ import print_function
import ast

#Function for finding the value of the key in the object
def findvalue(obj,key):
    try:
        first_set_value = (obj.get(key))
        if first_set_value:
            print("The value of " + str(key) + " is: " + str(first_set_value))
        else:
            for k, v in obj.items():
                second_set_value = v.get(key, 0)
                if second_set_value:
                    print("The value of " + str(key) + " is: " + str(second_set_value))
                else:
                    for k,v in obj.items():
                        for i, j in v.items():
                            print("The value of " + str(key) + " is: " + str(j[key]))
    except KeyError as e:
        print(e)

#Read Input
obj = input("Enter the Object: ")
convertobj = ast.literal_eval(obj)
key = input("Enter the key to be identified in object:")        
findvalue(convertobj,key)