import scrapy
from scrapy.http import HtmlResponse
from hh_parser.items import HhParserItem


class HhruSpider(scrapy.Spider):
    name = 'hh_ru'
    allowed_domains = ['hh.ru']
    start_urls = ['https://hh.ru/search/vacancy?clusters=true&enable_snippets=true&salary=&st=searchVacancy'
                  '&text=product+analyst']

    def parse(self, response: HtmlResponse):
        vacancies_links = response.xpath("//div[@class='vacancy-serp-item__info']//a/@href").extract()

        for link in vacancies_links:
            yield response.follow(link, callback=self.vacancy_parse)

        next_page = response.xpath("//a[contains(@class,'HH-Pager-Controls-Next')]/@href").extract_first()
        if next_page:
            yield response.follow(next_page, callback=self.parse)

    def vacancy_parse(self, response: HtmlResponse):
        name = response.xpath("//h1/text()").extract_first()
        vacancy_salary = response.xpath("//p[@class='vacancy-salary']//span/text()").extract()
        link = response.url
        yield HhParserItem(name=name, vacancy_salary=vacancy_salary, link=link)
