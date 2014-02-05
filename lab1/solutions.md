## File System
* What are the 10 biggest directories at depth 1 in /usr/lib on your virtual machine?
```
    find /usr/lib -mindepth 1 -maxdepth 1 -type d -exec du -hs {} \; | sort -hr | head -10
        205M	/usr/lib/libreoffice
        128M	/usr/lib/i386-linux-gnu
        87M	/usr/lib/chromium-browser
        69M	/usr/lib/python2.7
        46M	/usr/lib/thunderbird
        38M	/usr/lib/gcc
        35M	/usr/lib/firefox-7.0.1
        15M	/usr/lib/mono
        14M	/usr/lib/python2.6
        12M	/usr/lib/perl

    #Also works in this case:
    du -hs /usr/lib/* | sort -hr | head -10
```
    
* What are the 5 biggest directories in /home/saasbook, including hidden folders?
```
     find /home/saasbook -type d -exec du -hs {} \; | sort -hr | head
            656M	/home/saasbook
            627M	/home/saasbook/.rvm
            442M	/home/saasbook/.rvm/gems
            429M	/home/saasbook/.rvm/gems/ruby-1.9.3-p448
            222M	/home/saasbook/.rvm/gems/ruby-1.9.3-p448/gems
```

## Log Files

* What are the 5 most frequently visited URLs ?
```
    cat wc_day6_1.log| cut -d ' ' -f 7 | sort | uniq -c | sort -nr | head -5
      18525 /images/space.gif
      14584 /images/home_intro.anim.gif
      14123 /
      11886 /images/hm_nbg.jpg
      11477 /images/dot.gif
```

* Finally print the top 5 URLs which did not have return code 200.
```
    cat wc_day6_1.log | cut -d ' ' -f 7,9 | grep -v 200 | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head -10
       4158 /images/space.gif
       2605 /images/logo_cfo.gif
       2494 /images/nav_bg_top.gif
       2307 /images/home_intro.anim.gif
       2223 /english/index.html
```

* Print the number of requests that had HTTP return code 404. Next break down
number of 404 requests by date (i.e how many on 30th April and how many on 1st
May).
```
    wc_day6_1.log | cut -d ' ' -f 9 | grep 404 | wc -l
    1306

    cat wc_day6_1.log | cut -d ' ' -f 4,9 --output-delimiter=":" | cut -d ':' -f 1,5 --output-delimiter=" " | grep 404 | sort | uniq -c
    1221 [01/May/1998 404
    85 [30/Apr/1998 404
```

## Clean worldcup.txt

```bash
sed 's/\[\[\([0-9]*\)[^]]*\]\]/\1/g;
     s/.*fb|\([A-Za-z]*\)}}/\1/g;
     s/<sup><\/sup>//g;
     s/|bgcolor[^|]*//g;
     s/|align=center[^|]*//g
     s/^\|[^(]*(//; s/).*$//g
     s/[ \t]//g' < worldcup.txt > clean_worldcup.txt
```

## Transform clean_worldcup.txt

```bash
awk -F, '/^[A-Z]{3}/ { c = $0; i = 0 } /^[^A-Z]{3}/ { ++i } 
         /[0-9]{4}/ {
                for (j=1; j<=NF; j++) { 
                        print c","i","$j 
                } 
         } ' < clean_worldcup.txt
```

## Challenge Exercises
* Print the number of HTTP requests that had return code 404 in each hour of the day.
```
    cat wc_day6_1.log | cut -d ' ' -f 4,9 --output-delimiter=":" | cut -d ':' -f 2,5 --output-delimiter=" " | grep 404 | sort | uniq -c
         30 00 404
         73 01 404
         39 02 404
         40 03 404
         66 04 404
        170 05 404
         24 06 404
         40 07 404
         73 08 404
         61 09 404
         53 10 404
         43 11 404
         42 12 404
         77 13 404
         48 14 404
         45 15 404
        102 16 404
         55 17 404
         38 18 404
         49 19 404
         32 20 404
         21 21 404
         51 22 404
         34 23 404
```
* Break down the number of HTTP requests that did not have a 200 return code by date (i.e. how many responses were 304, 404, etc. on each day).

```
        cat wc_day6_1.log | cut -d ' ' -f 4,9 --output-delimiter=":" | cut -d ':' -f 1,5 --output-delimiter=" " | grep -v 200| sort | uniq -c
        8 [01/May/1998 -
        1957 [01/May/1998 206
        44 [01/May/1998 302
        139175 [01/May/1998 304
        19 [01/May/1998 400
        1221 [01/May/1998 404
        20 [01/May/1998 500
        173 [30/Apr/1998 206
        4 [30/Apr/1998 302
        12171 [30/Apr/1998 304
        4 [30/Apr/1998 400
        85 [30/Apr/1998 404
        1 [30/Apr/1998 500
```

