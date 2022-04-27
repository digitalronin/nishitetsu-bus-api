# Nishitetsu Bus API

Attempting to use the Nishitetsu web interface to create a workable API for building a decent bus app.

## Setup

To rebuild from scratch

- Remove references to Gemfile.lock from Dockerfile and makefile
- `make shell`
- In the container shell, run `bundle install`
- In a separate terminal, add and commit the Gemfile.lock
- Replace references to Gemfile.lock in Dockerfile and makefile

## Heroku setup

```
heroku apps:create nishitetsu-bus
heroku stack:set container
git push heroku main
```

## TODO

- iterate over all bus stops to get the lines they're on
- draw bus stops on openstreetmap
- draw bus routes on openstreetmap
- enable searching for the single bus journey that best connects two points on the map
- replace 2 route links with a "reverse the journey" control
- use collapsible to display bus departures, and show more info when user taps
- make the refresh link into a button
- add a favicon

## MISC

API base:

    http://busnavi01.nishitetsu.ne.jp/

Search for bus stop by name:

    curl -d 'f=search_bustei&ftKbn=j&jkeyword=%E7%A6%8F%E5%B2%A1%E5%A5%B3%E5%AD%90%E5%A4%A7%E5%89%8D&cflg=0' http://busnavi01.nishitetsu.ne.jp/

    # f: search_bustei
    # ftKbn: j
    # jkeyword: 福岡女子大前
    # cflg: 0

### Search for bus stops on a map (JSON):

```
bin/get-bus-stops.rb
```

### Get bus route numbers for bus stop (html only :( ):

    curl 'http://busnavi01.nishitetsu.ne.jp/busroute?f=busikisaki&list=0001,660102&ns=1&tei_type=0'

Get timetable for buses from stop (html only):

    curl 'http://busnavi01.nishitetsu.ne.jp/busroute?list=0001,660102&t=012,2'

t=012,2 must be the selected route + direction (in this case 21A/23A/26A towards Tenjin)
