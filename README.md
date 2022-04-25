# Nishitetsu Bus API

Attempting to use the Nishitetsu web interface to create a workable API for building a decent bus app.

## Setup

To build from scratch

- Remove references to Gemfile.lock from Dockerfile and makefile
- `make shell`
- In the container shell, run `bundle install`
- In a separate terminal, run `docker exec $(TAG) cat Gemfile.lock`
- Edit the new Gemfile.lock and remove all lines before 'GEM'
- Commit the Gemfile.lock
- Replace references to Gemfile.lock in Dockerfile and makefile

## Heroku setup

```
heroku apps:create nishitetsu-bus
heroku stack:set container
git push heroku main
```

API base:

    http://busnavi01.nishitetsu.ne.jp/

Search for bus stop by name:

    curl -d 'f=search_bustei&ftKbn=j&jkeyword=%E7%A6%8F%E5%B2%A1%E5%A5%B3%E5%AD%90%E5%A4%A7%E5%89%8D&cflg=0' http://busnavi01.nishitetsu.ne.jp/

    # f: search_bustei
    # ftKbn: j
    # jkeyword: 福岡女子大前
    # cflg: 0


Get bus route numbers for bus stop (html only :( ):

    curl 'http://busnavi01.nishitetsu.ne.jp/busroute?f=busikisaki&list=0001,660102&ns=1&tei_type=0'

Get timetable for buses from stop (html only):

    curl 'http://busnavi01.nishitetsu.ne.jp/busroute?list=0001,660102&t=012,2'

t=012,2 must be the selected route + direction (in this case 21A/23A/26A towards Tenjin)


Live departure information (html only):

     curl http://busnavi01.nishitetsu.ne.jp/route?f_zahyo_flg=0&f_list=0001%2C660102&t_zahyo_flg=0&t_list=0000%2CL00001&rightnow_flg=2&sdate=2022%2F04%2F24&stime_h=12&stime_m=50&stime_flg=1&jkn_busnavi=1&syosaiFlg=0

    f_zahyo_flg: 0
    f_list: 0001,660102
    t_zahyo_flg: 0
    t_list: 0000,L00001
    rightnow_flg: 2
    sdate: 2022/04/24
    stime_h: 12
    stime_m: 50
    stime_flg: 1
    jkn_busnavi: 1
    syosaiFlg: 0

I think f_list and t_list are "from" and "to"

## TODO

- add reload link with icon where time is shown
- replace 2 route links with a "reverse the journey" control

