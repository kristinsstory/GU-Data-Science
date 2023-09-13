
import json
import pickle


my_favourite_group = {'name': 'Ludovico Einaudi',
                      'tracks': ['Experience', 'Watereways' 'Golden Butterflies'],
                      'albums': [{'name': 'Seven Days Walking', 'year': 2019},
                                      {'name': 'In a Time Lapse', 'year': 2013},
                                      {'name': 'Nightbook', 'year': 2009}]}


j_group = json.dumps(my_favourite_group)
print(j_group)

with open('fav_group.json', 'w', encoding='utf-8') as f:
    json.dump(my_favourite_group, f)
    
    
p_group = pickle.dumps(my_favourite_group)
print(p_group)

with open('fav_group.pickle', 'wb') as f:
    pickle.dump(my_favourite_group, f)
