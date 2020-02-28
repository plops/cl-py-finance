#!/usr/bin/env python3
import selenium.webdriver
import selenium.webdriver.support
import selenium.webdriver.support.wait
import selenium.webdriver.common.by
import selenium.webdriver.support.expected_conditions
import selenium.webdriver.common.keys
import datetime
import calendar
import pandas as pd
import numpy as np
import time
import pathlib
import re
def sel(css):
    return driver.find_element_by_css_selector(css)
def selx(xpath):
    return driver.find_element_by_xpath(xpath)
def wait_css_clickable(css):
    wait.until(selenium.webdriver.support.expected_conditions.element_to_be_clickable((selenium.webdriver.common.by.By.CSS_SELECTOR,css,)))
def wait_css_gone(css):
    wait.until(selenium.webdriver.support.expected_conditions.invisibility_of_element_located((selenium.webdriver.common.by.By.CSS_SELECTOR,css,)))
def wait_css_clickable(css):
    wait.until(selenium.webdriver.support.expected_conditions.element_to_be_clickable((selenium.webdriver.common.by.By.CSS_SELECTOR,css,)))
def waitsel(css):
    wait_css_clickable(css)
    return sel(css)
firefox_profile=selenium.webdriver.FirefoxProfile()
driver=selenium.webdriver.Firefox(firefox_profile=firefox_profile)
wait=selenium.webdriver.support.wait.WebDriverWait(driver, 30)
driver.install_addon("/tmp/store_webrequest.xpi", temporary=True)
driver.get("https://finance.yahoo.com/quote/NVD.F")
sel(".btn.primary").click()
