from scrapy.crawler import CrawlerProcess
from scrapy.settings import Settings

from leroy_merlin.spiders.leroy import LeroymerlinSpider
from leroy_merlin import settings

if __name__ == '__main__':
    crawler_settings = Settings()
    crawler_settings.setmodule(settings)

    process = CrawlerProcess(settings=crawler_settings)
    process.crawl(LeroymerlinSpider, search='Дверь')

    process.start()
