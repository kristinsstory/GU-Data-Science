from pymongo import MongoClient

client = MongoClient('localhost', 27017)
mongo_base = client.instagramparser
collection = mongo_base['instagram']


for i in collection.find({"user_id": " "}):
    print(i)

print('subscribe')
for i in collection.find({"subscribe_user_id": " "}):
	print(i) 


# yield response.follow(
#                     url_subscribers,
#                     callback=self.user_subscribers_parse,
#                     cb_kwargs={'username':username,
#                                'user_id': user_id,
#                                'variables': deepcopy(variables)}
#                 )
# yield response.follow(
#                     url_subscribe,
#                     callback=self.user_subscribe_parse,
#                     cb_kwargs={'username': username,
#                                'user_id': user_id,
#                                'variables': deepcopy(variables)}
#                 )