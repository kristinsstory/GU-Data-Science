# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html

from pymongo import MongoClient
import re
from bs4 import BeautifulSoup as bs
import requests

# response = requests.get(link, headers=header, params=params)
# soup = bs(response.text, 'html.parser')



class HhParserPipeline:
    def __init__(self):
        client = MongoClient('localhost', 27017)
        self.mongo_base = client.vacancy


    def process_item(self, item, spider):

        collection = self.mongo_base[spider.name]

        item['salary_min'] = None
        item['salary_max'] = None
        if spider.name == 'hh_ru':
            item['site'] = 'https://hh.ru/'
            if item['vacancy_salary'][0] == 'от ':
                item['salary_min'] = int(re.sub('\D', '', item['vacancy_salary'][1]))
                item['salary_max'] = int(re.sub('\D', '', item['vacancy_salary'][3])) if item['vacancy_salary'][
                                                                                             0] > ' до ' else None
            elif item['vacancy_salary'][0] == 'до ':
                item['salary_min'] = None
                item['salary_max'] = int(re.sub('\D', '', item['vacancy_salary'][1]))

        del item['vacancy_salary']
        collection.insert_one(item)
        
        return item
