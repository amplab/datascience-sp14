# Using UNIX command line utilities

In this lab you will use UNIX command line utilities to do some data cleaning
and basic analysis. At the end of the exercise, remember to fill out the
response form at http://goo.gl/VPhVGW .

## Section 1: File System Analytics

In this exercise, we'll use some of the basic aggregation facilities provided by
UNIX tools to do some analysis of the file system on your virtual machine.

### Navigating the file system

If you've used the terminal on a Linux or UNIX system before, you're probably
very familiar with `ls` and `cd`. `ls` has some great extended options, but
accessing the results of `ls` programmatically can be difficult, and tasks like
getting access to filenames recursively can be tricky.

#### find

`find` provides a much more flexible interface to listing files that match a
particular criteria than ls. In particular, you can easily restrict yourself to
a particular type of file (e.g. directories or plain files), recurse
indefinitely or to some maximum depth, dispatch an action on file names that
match your search, or pair the results of find with a command like `xargs` to do
something further with files that match your filters.

For example, the command `find /usr/bin -type f -name 'py*'` will tell find to
list the names of all ordinary files (not directories) in `/usr/bin` whose names
start with "py".

#### du

Understanding what files/directories are using space on the file system is a
problem that people have been dealing with since UNIX was invented. According to
the man page for `du`, "A `du` command appeared in Version 1 AT&T UNIX."

`du` allows you to report usage statistics of files and directories in your
system. By default, it reports its usage statistics at the block level, but the
`-h` option provides this information in a human-readable format. It's worth
noting that the results of `du` are not exact - instead sizes are reported as
multiples of block size.

Try running `du -hs *` in your home directory to see where the space is going.

Now, think about how you could output the results of `find` into `du` to do reporting on a subset of files.

### Sorting

The `sort` command is pretty powerful. In most systems, it is implemented via an
external merge sort - this makes it possible to sort really huge files, even
ones that don't fit into memory, in a reasonable amount of time. 

By default, `sort` will sort items lexicographically, but with the `-n` flag it
will sort in numeric order. This means that 10100 will come after 2 in numeric
sort order, even though it precedes 2 lexicographically. In recent versions of
GNU `sort`, the command also takes a `-h` parameter, which allows you to sort
human-readable numbers (like file sizes produced by du -h).

Additionally, `sort` will let you select exactly which fields of a file you want
to sort on (by default, it's the whole line), and in which order these fields
should be sorted.

### Exercises
1.1. What are the 10 biggest directories at depth 1 in /usr/lib on your virtual machine?

1.2. What are the 5 biggest directories in /home/saasbook, including hidden folders?

## Section 2: Log processing with command line tools

In the next exercise we will look at tools which you can use to quickly analyze
and explore text files.

### Downloading data files

The first step in data analyis is typically downloading data files that you need
to process. While typically you might be used to downloading files using your web
browser, this gets tedious when you want to download many files or if you want to
automate the process. There are UNIX command line tools which you can use in
such cases to download files

#### curl
`curl` is a commonly used tool for downloading files. It is typically available
on most UNIX machines and should be installed in your VM. To download a file
using curl you need to run `curl <url> -o <filename>`. For example to download
the course webpage in html you can run something like

    curl http://amplab.github.io/datascience-sp14/index.html -o index.html

This will download the course webpage and save it to a file named `index.html`
in your current directory. This is of course a simple example of how you can use
`curl`. You can find other options using and features in the curl manpage using
`man curl`.

#### wget
Another popular command line tool used for downloading data is `wget`. You might
have seen this used in other examples or used it before. For simple use cases
you can use either tool and we will use `curl` for this exercise. A more detailed
comparison of the two tools can be seen at
[curl vs wget](http://daniel.haxx.se/docs/curl-vs-wget.html).

### HTTP Logs Dataset

For this exercise we will be using HTTP access logs from the 1998 Soccer
WorldCup website. The [complete
dataset](http://ita.ee.lbl.gov/html/contrib/WorldCup.html) contains
around 1.3 billion requests, and we will use a subset of it for this exercise.
As a first step download the sample dataset using `curl` from
`https://raw.github.com/amplab/datascience-sp14/master/lab1/data/wc_day6_1_log.tar.bz2` .

The dataset has been compressed to make the download finish faster. To get the
raw data unzip the downloaded file by running `tar -xf <filename>`. (Note: `tar`
is also a very frequently used command line tool and you can learn more about it
with `man tar`).

Having extracted the file, take a look at how the file looks by running `less
wc_day6_1.log`. This will show you the first few lines of the file and you can
page through the file using the arrow keys. You will notice that each hit or
access to the website is logged as in a new line in the log file. The format of
each line is in the [Common Log File
Format](https://en.wikipedia.org/wiki/Common_Log_Format) and this format is used
by most HTTP servers. In this case the data has been annonymized and lets take a
look at one line from the file to explain each field

    57 - - [30/Apr/1998:22:00:48 +0000] "GET /english/images/lateb_new.gif HTTP/1.0" 200 1431

In the above line `57` refers to a `clientID`, a unique integer identifier for the
client that issued the request. While this field typically contains the IP
address, for privacy reasons it has been replaced with an integer. The next two
fields are `-` and say that the fields are missing from the log entry. Again
these correspond to `user-identifier`, `userid` and have been removed for
privacy reasons.

The next field is the time at which the request was made and this is followed by
the HTTP request that was made. In this example a GET request was made for
`lateb_new.gif`. The next field is the HTTP return code and in this example it
is 200. You can find a list of codes and their meanings from
[w3](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html). The last field is
the size of the object returned to the client, measured in bytes.

### Exploring the dataset

Before we get to the exercises, lets explore the dataset and try out some basic
commands.

First up lets count how many visits the website got. To do this we just count
the number of lines in the file by running `wc -l wc_day6_1.log`. Your output
should look like

    1193353 wc_day6_1.log

We can do something more interesting by finding out how many times the ticketing
webpage was visited. To do this you could run

    grep tickets wc_day6_1.log | wc -l
    29818

However the above line counts images and other elements which have the word
`tickets` in their path. (Note: You can verify this using `less`). To restrict
it to just `html` pages, you can use a regular expression

    grep "tickets.*html" wc_day6_1.log | wc -l
    2776

We can also prune the dataset to only look at interesting parts of it. For
example we can just look at the first 50 URLs and their sizes using the `head`
and `cut` command.

    head -50 wc_day6_1.log | cut -d ' ' -f 7,10

In the above command the `-d` flag denotes what delimiter to use and `-f` stats
what fields should be selected from the line. Try out different delimiter and
field values to see how `cut` works.

Finally we can see how many unique URLs are there in the first 50 visits. To do
this we could run something like

    head -50 wc_day6_1.log | cut -d ' ' -f 7 | sort | uniq | wc -l

Here we use the tool `uniq` to only count unique URLs. Note that the input to
`uniq` should be sorted, so we use `sort` before calling `uniq`. The `uniq` tool
can also be used to count how many times an item occurs by passing it the `-c` flag.
For example if we run the same command as above but with `uniq -c` we'll get

    head -50 wc_day6_1.log  | cut -d ' ' -f 7 | sort | uniq -c | tail -10
      1 /images/home_fr_phrase.gif
      2 /images/home_intro.anim.gif
      1 /images/home_logo.gif
      1 /images/home_sponsor.gif
      1 /images/home_tool.gif
      1 /images/logo_cfo.gif
      1 /images/nav_bg_top.gif
      1 /images/team_hm_afc.gif
      1 /images/team_hm_caf.gif
      1 /images/team_hm_concacaf.gif

This shows that `/images/home_intro.anim.gif` occured twice in the first 50 URLs.

### Exercises

Now use the above tools to answer some analysis questions

2.1 What are the 5 most frequently visited URLs ?

2.2 Print the top 10 URLs which did not have return code 200.

2.3 Print the number of requests that had HTTP return code 404. Next break down
number of 404 requests by date (i.e how many on 30th April and how many on 1st
May).

## Challenge Exercises (Optional)

2.4. Print the number of HTTP requests that had return code 404 in each hour of
   the day.
   
2.5. Break down the number of HTTP requests that did not have a 200 return code by date
   (i.e. how many responses were 304, 404, etc. on each day).


## Section 3: Data cleaning and transformation with sed, awk

In this exercise we will learn how to use command line tools to transform
structured data into a clean CSV format.

### Dirty Data

Data analysts spend a large fraction of their time cleaning and prepraring data
for use.  The reason is simple:  given all the uses of data, it is natural for
it to be stored in a wide variety of formats, each with its own strengths and
weaknesses, and each appropriate to its particular application.  Rarely is data
found in the wild in exactly the proper format for a desired analysis tool, so
analysts must transform the data before loading it.  UNIX tools provide powerful
low-level support for cleaning and transformation operations, and can be
invaluable aids for rapid data ingest.

A common case is to work with data structured for presentation (e.g., in a wiki
table) instead of for analysis.

For this exercise, we will be working with one such example.  Download the file
worldcup.txt from
`https://raw.github.com/amplab/datascience-sp14/master/lab1/data/worldcup.txt`
(e.g., with `curl` or `wget`).  This file contains the source of a wiki table
listing top finishers in the soccer (football?) World Cup since 1938.

The goal of this exercise is to transform the World Cup data file into a clean,
relational format:

```
nation,year,place
ITA,1938,1
...
```

To get there, we will need to remove syntactic cruft and pivot the data layout,
all of which can be done with two powerful tools: `sed` and `awk`.

### Regular Expressions

All of the operations we will be using are driven by regular expression pattern
matching.  Regular expressions are encoded patterns that can be matched against
a string.  Hopefully, you already have some familiarity with regex, but if not
at least you get to experience [this](https://xkcd.com/208/) today.

We have prepared a short introduction to [regular expressions](
https://github.com/amplab/datascience-sp14/blob/master/lab1/regex.md) that
might be useful if you want a quick overview. More detail is easy to find online, for
example, in the [Awk Manual](http://www.staff.science.uu.nl/~oostr102/docs/nawk/nawk_46.html).

### Removing Cruft with sed

Time to start cleaning the data!

The first thing to notice about `worldcup.txt` is that there is a lot of raw
HTML and wiki cruft in it.  Our first goal is to remove the extraneous bits.

`sed` (short for "Stream EDitor") is a tool for modifying text files
programmatically and line by line.  We will use two important `sed` commands to
clean up the file.

#### Substitution

Substitution with `sed` is essentially an efficient way to perform search and
replace on a file with regular expressions.  You can run a substitute command as
follows:

``` 
cat in.txt | sed 's/regexPattern/replacementString/flags' > out.txt 
```

Lets use substitution to start removing cruft from our file.  First, we will
focus on lines that contain country codes (these look like `BRA`, `ITA`, `GER`,
etc.).  These lines all look something like the following:

``` 
|bgcolor=#FFF68F|{{fb|BRA}} 
```

Here, the only piece of actual data is `BRA`, so we want to delete the rest.
The cruft is a fixed string in all cases so we can use two simple regex
patterns:

``` 
cat worldcup.txt | sed 's/^|bgcolor=#FFF68F|{{fb|//' | sed 's/}}$//' 
```

#### Line Deletion

Another useful `sed` command is line deletion, i.e., delete all lines that match
a regex pattern.  The syntax is:

``` 
cat in.txt | sed '/regexPattern/d' > out.txt 
```

In `worldcup.txt` there are many lines that do not contain content.  We will use
`sed` delete to remove the footer lines from the file.  These lines all look
something like the following:

``` 
:<div id="1">''<nowiki>*</nowiki> = hosts'' 
```

We can use their common prefix, `":<div id="`, to match them.  Then we run:

``` 
cat worldcup.txt | sed '/^:<div id="/d' 
```

#### Task

3.1 Use `sed` substitution and deletion to remove meaningless content from
`worldcup.txt`.  In the end, you should have a file that only contains the
relevant data: country codes, years, and in what place teams finished.

Note that some of the important data is not encoded explicitly in the file.
(For example, how do you know in what years a team finished in 3rd place?)  Be
careful while cleaning the file not to lose any of the meaningful content from
the data!  In the following section, we will use `awk` to make all of the data
explicit.


### awk

By this point, we have a relatively clean data file, but its structure is
complex.  Some lines have country codes on them while others have years.  Some
lines with years list multiple years while others list just one (or none!).

We will use `awk` to transform the data into a simple CSV format.  `awk` is a
Turing complete scripting language with an interface especially good at
processing files line by line.  A brief introduction to `awk` follows, and as
always, for more information try `man awk` or Google for the `awk` manual (or
other great resources) online.

The basic structure of an `awk` script is as follows:

``` 
awk 'BEGIN { init } 
     /pattern1/ { pattern1expr } 
     /pattern2/ { pattern2expr }
     ...  
     END { finish }' file.txt
```

Here, the code contained between curly braces are code expressions to be
evaluated when the preceding pattern is matched.  `awk` loops over the input
file line by line, and when the current line matches a pattern, the code
belonging to that pattern is run.  `BEGIN` and `END` are special patterns that
match the beginning and end of the file, respectively (they are optional).

To demonstrate a simple script, we will count the number of countries listed in
`worldcup.txt`.  We assume country codes are all on their own line at this
point.  Then we run:

``` 
awk 'BEGIN { i = 0 } 
     /^[A-Z]{3}$/ { ++i } 
     END { print i }' clean_worldcup.txt
```

This script initializes a counter, `i`, at the start, increments it on every
line matching our country code pattern, and uses the `print` statement to write
the counter to `stdout` after the file is done.

Keep in mind that each code block can run any number of statements (including
loops and conditionals) separated by semicolons.  The syntax is C-like and
should be familiar; type `man awk` to get a concise overview of available
commands and functions.

#### Fields

`awk` is especially good at parsing structured (i.e., record-like) lines of
text.  Invoking `awk` with the flag `-F<regex>` sets the "field separator" to
the provided regular expression (usually just a comma or tab character).  With
the field separator set, fields in a matched line become available to script
code as the variables `$1, $2, ...`.  So the following two commands are
equivalent:

``` 
awk -F, '/.*/ { print $2 }' file 
cut -d, -f2 file
```

NB: the variable `$0` contains the text of the entire current line.

#### Task

3.2 Write an `awk` script (or small set of scripts) to transform your cleaned
`worldcup.txt` data file into a CSV with the following structure:

```
nation,year,place
ITA,1938,1
... 
```

## Lab 1 responses

Finally we have a few questions for you based on the above exercises. Fill out
your responses at http://goo.gl/VPhVGW .

