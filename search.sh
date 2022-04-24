#!/bin/bash

set -euo pipefail

# http://busnavi01.nishitetsu.ne.jp/
#
# f: search_bustei
# ftKbn: j
# jkeyword: 福岡女子大前
# cflg: 0

# curl -d 'f=search_bustei&ftKbn=j&jkeyword=%E7%A6%8F%E5%B2%A1%E5%A5%B3%E5%AD%90%E5%A4%A7%E5%89%8D&cflg=0' http://busnavi01.nishitetsu.ne.jp/


# Area search

# f: maptei
# lat: 33.6623351
# lon: 130.4460494
# area: 0.00477175299999999
# tei_type[]: 0
# tei_type[]: 1

# curl -d 'f=maptei&lat=33.6623351&lon=130.4460494&area=0.00477175299999999&tei_type%5B%5D=0&tei_type%5B%5D=1' http://busnavi01.nishitetsu.ne.jp/map

curl -d 'f=busikisaki&list=0001,660102&ns=1&tei_type=0' http://busnavi01.nishitetsu.ne.jp/busroute
