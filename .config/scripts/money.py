#!/usr/bin/python
from collections import defaultdict
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from forex_python.converter import CurrencyRates
import pandas_datareader as web
from datetime import date, timedelta,datetime

class Money:
    def __init__(self, loc='20211220.csv'):
        dt = loc.split('.')[-2]
        dt = dt if '/' not in dt else dt.split('/')[-1]
        self.yr, self.mth, self.day = int(dt[:4]), int(dt[4:6]), int(dt[6:])
        self.c = CurrencyRates()
        self.cryptos = ['BTC', 'ETH']
        df = pd.read_csv(loc)
        arr = []
        for _, row in df.iterrows():
            arr.append([
                row['bank'],
                self._2usd(row['amount'], row['currency']),
                row['currency']
            ])
        self.df = pd.DataFrame(arr, columns=['bank', 'usd', 'orig'])
            
    def _2usd(self, amount, frm):
        dt = date(self.yr, self.mth, self.day)
        if frm.upper() not in self.cryptos:
            try:
                return self.c.get_rate(frm.upper(), 'USD', dt) * amount
            except:
                return self.c.get_rate(frm.upper(), 'USD', date.today() - timedelta(days=3)) * amount
        else:
            info = web.DataReader(f'{frm.upper()}-USD', 'yahoo', dt - timedelta(days=3), dt)
            return float(sum(info.loc[f'{self.yr}-{self.mth}-{self.day}'][:4])/4) * amount
        
    def _fromusd(self, amount, to):
        dt = date(self.yr, self.mth, self.day)
        if to.upper() not in self.cryptos:
            try:
                return self.c.get_rate('USD', to.upper(), dt) * amount
            except:
                return self.c.get_rate('USD', to.upper(), date.today() - timedelta(days=1)) * amount
        else:
            info = web.DataReader(f'{to.upper()}-USD', 'yahoo', dt - timedelta(days=1), dt)
            return 1 / float(sum(info.loc[f'{self.yr}-{self.mth}-{self.day}'][:4])/4) * amount
   
    def _group(self, name):
        if name == 'bank':
            df = self.df.groupby(by='bank').sum()
        elif name == 'currency':
            df = self.df.groupby(by='orig').sum()
        return df.sort_values(by='usd', ascending=False)
    
    def pieplot(self, by):
        df = self._group(by)
        plt.pie(df['usd'], labels=[k.title() for k in df.index])
        plt.show()
        
    def total(self, curr='USD'):
        return self._fromusd(self.df['usd'].sum(), curr)
    
    def info(self):
        total = self.total()
        out = ''
        out += ', '.join([f"{ind.title()}: %{round(row[0]/total*100, 2)}" for ind, row in self._group('bank').iterrows()])
        out += '\n'
        out += ', '.join([f"{ind.upper()}: %{round(row[0]/total*100, 2)}" for ind, row in self._group('currency').iterrows()])
        out += '\n'
        out += "Total: {:.4f} BTC = {:.3f} ETH = {:d} USD".format(self.total('BTC'), self.total('ETH'), int(self.total('USD')))
        print(out)

    def polybar(self):
        print(', '.join([f"{ind.upper()}: {round(row[0]/self.total()*100, 2)}%" for ind, row in self._group('currency').iterrows()]))

    def vis(self):
        fig, axes = plt.subplots(1,2)
        axes = axes.flatten()
        for i, by in enumerate(['bank', 'currency']):
            df = self._group(by)
            axes[i].pie(df['usd'], labels=[k.title() for k in df.index])
        plt.title("Total: {:.4f} BTC = {:.3f} ETH = {:d} USD".format(self.total('BTC'), self.total('ETH'), int(self.total('USD'))))
        plt.show()
