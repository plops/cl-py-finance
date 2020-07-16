#!/usr/bin/env python3
import datetime
import calendar
import pandas as pd
import numpy as np
import time
import pathlib
import re
import requests
stocks=["LITE", "NVDA", "AMD", "ASML", "INTC", "BDX"]
headers={("authority"):("api.nasdaq.com"),("accept"):("application/json, text/plain, */*"),("user-agent"):("Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36"),("origin"):("https://www.nasdaq.com"),("sec-fetch-site"):("same-site"),("sec-fetch-mode"):("cors"),("sec-fetch-dest"):("empty"),("referer"):("https://www.nasdaq.com/market-activity/stocks/lite/latest-real-time-trades"),("accept-language"):("en-US,en;q=0.9")}
params=(("","",),("limit","20",),("fromTime","00:00",),)