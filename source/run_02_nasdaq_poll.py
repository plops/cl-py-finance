#!/usr/bin/env python3
import datetime
import time
import calendar
import pandas as pd
import numpy as np
import time
import pathlib
import re
import requests
import json
symbols=["TSLA", "LITE", "NVDA", "AMD", "ASML", "INTC", "BDX"]
def get_ticks(symbol, timestamp="00:00", limit=100):
    print("requesting last {} trades for {} ".format(limit, symbol))
    headers={("authority"):("api.nasdaq.com"),("accept"):("application/json, text/plain, */*"),("user-agent"):("Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36"),("origin"):("https://www.nasdaq.com"),("sec-fetch-site"):("same-site"),("sec-fetch-mode"):("cors"),("sec-fetch-dest"):("empty"),("referer"):("https://www.nasdaq.com/market-activity/stocks/lite/latest-real-time-trades"),("accept-language"):("en-US,en;q=0.9")}
    params=(("","",),("limit","{}".format(limit),),("fromTime",timestamp,),)
    response=requests.get("https://api.nasdaq.com/api/quote/{}/realtime-trades".format(symbol), headers=headers, params=params)
    ticks=json.loads(response.text)
    df=pd.DataFrame(ticks["data"]["rows"])
    df["request_time"]=pd.Timestamp.now()
    return df
def run(timestamp="00:00", limit=20):
    print(get_ticks(symbols[0], timestamp=timestamp, limit=limit))
symb=symbols[0]
a=get_ticks(symb, limit=100)
time.sleep(5)
b=get_ticks(symb, limit=100)
compare_cols=a.columns[[0, 1, 2]]
# find the row in b that is identical to the most recent row in a
first_identical=b[((b[compare_cols])==(a.iloc[0][compare_cols])).all(axis=1)]