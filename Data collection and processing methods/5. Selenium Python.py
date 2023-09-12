# 1) Написать программу, которая собирает входящие письма из своего или тестового почтового ящика
# и сложить данные о письмах в базу данных (от кого, дата отправки, тема письма, текст письма полный)
# Логин тестового ящика: study.ai_172@mail.ru
# Пароль тестового ящика: NextPassword172

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
from selenium.webdriver.common.by import By
from pymongo import MongoClient
from pprint import pprint
import time

client = MongoClient('127.0.0.1', 27017)
db = client['email']
mail_ru = db.mailru

mail_ru.delete_many({})

chrome_options = Options()
chrome_options.add_argument('start-maximized')
driver = webdriver.Chrome(options=chrome_options)
driver.get('https://account.mail.ru')

elem = WebDriverWait(driver, 10).until(
    ec.visibility_of_element_located((By.NAME, 'username'))
)
elem.send_keys('study.ai_172@mail.ru')
elem.send_keys(Keys.ENTER)


elem = WebDriverWait(driver, 10).until(
    ec.visibility_of_element_located((By.NAME, 'password'))
)
elem.send_keys('NextPassword172')
elem.send_keys(Keys.ENTER)

first_mail = WebDriverWait(driver, 10).until(
    ec.visibility_of_element_located((By.CLASS_NAME, 'llc'))
)


if first_mail:
    first_mail.click()

    count = 0
    while True:
        time.sleep(1)
        mail = {}
        contact = driver.find_element_by_xpath('//div[@class="letter__author"]/span').get_attribute('title')
        date = driver.find_element_by_xpath('//div[@class="letter__date"]').text
        header = driver.find_element_by_xpath('//h2').text
        body = driver.find_element_by_xpath('//div[@class="letter__body"]').text

        mail['contact'] = contact
        mail['date'] = date
        mail['header'] = header
        mail['body'] = body

        # emails_list.append(mail)
        mail_ru.insert_one(mail)
        count += 1

        try:
            driver.find_element_by_xpath('//span[contains(@class, "button2_arrow-down")]').click()
        except Exception:
            break

    for m in mail_ru.find({}):
        pprint(m)
    pprint(f'Количество писем: {count}')
    driver.close()
