#!/usr/bin/python
import sys
from money import Money

if len(sys.argv) > 0:
    m = Money(sys.argv[1])
else:
    m = Money(f'~/priv/port/20211220.csv')

m.polybar()
