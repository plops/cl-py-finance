#!/usr/bin/env python3
# pip3 install --user mplfinance quandl
import matplotlib.pyplot as plt
import mplfinance as mpf
plt.ion()
import quandl
import datetime
import calendar
import pandas as pd
import numpy as np
import time
import pathlib
import re
f=open("p")
pw=f.read().replace("\n", "")
f.close()
quandl.ApiConfig.api_key=pw
d=quandl.get("EURONEXT/ASML", start_data="2019-03-02")
d=d.rename(columns={("Last"):("Close")})
mpf.plot(d, type="candle", volume=True)