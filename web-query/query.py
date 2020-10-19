from selenium import webdriver
from tldextract import extract
from time import sleep
import csv


driver = webdriver.Remote(command_executor="http://localhost:8080")
driver.set_window_size(1920, 1080)


def browse(url, filename):
    driver.delete_all_cookies()
    driver.get("https://" + url)
    result = None
    while result != "complete":
        result = driver.execute_script("return document.readyState;")
        sleep(1)
    driver.save_screenshot("screenshots/" + filename + ".png")


with open('top500Domains.csv', 'r') as csvfile:
    reader = csv.reader(csvfile)
    next(reader, None)  # skip the headers

    for i in reader:
        rank = i[0]
        domain = i[1]
        filename = rank.zfill(3) + "-" + domain
        print(rank, domain)
        browse(domain, filename)
        if int(rank) == 300:
            break

driver.close()