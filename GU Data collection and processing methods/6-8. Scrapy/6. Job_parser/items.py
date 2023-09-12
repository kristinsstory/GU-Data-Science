# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class HhParserItem(scrapy.Item):
    # define the fields for your item here like:
    name = scrapy.Field()
    vacancy_salary = scrapy.Field()
    salary_min = scrapy.Field()
    salary_max = scrapy.Field()
    link = scrapy.Field()
    _id = scrapy.Field()
    site = scrapy.Field()
    pass
