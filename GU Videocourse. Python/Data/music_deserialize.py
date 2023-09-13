
import json
import pickle

with open('fav_group.json', 'r', encoding='utf-8') as f:
    result = json.load(f)
print(result)


with open('fav_group.pickle', 'rb') as f:
    result1 = pickle.load(f)
print(result1)
