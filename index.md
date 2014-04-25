---
title: CS194-16 Introduction to Data Science
layout: default
---

# CS 194-16 Introduction to Data Science - UC Berkeley, Spring 2014

Organizations use their data for decision support and to build data-intensive
products and services. The collection of skills required by organizations to
support these functions has been grouped under the term Data Science. This
course will attempt to articulate the expected output of Data Scientists and
then equip the students with the ability to deliver against these expectations.
The assignments will involve web programming, statistics, and the ability to
manipulate data sets with code.

## Logistics

* Course Number: CS 194-16, CS 294-16 Spring 2014, UC Berkeley
* Instructor: [Mike Franklin](http://cs.berkeley.edu/~franklin)
* Time: Monday, 5.30pm - 8.30pm
* Location: 145 Moffit
* Teaching Assistants: Daniel Bruckner, Evan Sparks and Shivaram Venkataraman
* Discussion: Join [Piazza](https://piazza.com/class/ho9kqs2efao27y) for
  announcements and to ask questions about the course
* Office hours:
  - Mike Franklin - T 3.30-4.30, Th 2.30-3.30 at 449 Soda
  - GSIs - M 2-3 at 449 Soda, W 11-12 at 751 Soda

## Pre-requisites
Pre-requisites for this course include 61A, 61B, 61C and basic programming
skills. Knowledge of Python will be useful for the assignments. Students
will also be expected to run [VirtualBox](https://www.virtualbox.org/) on their laptops
for the assignments.

Please take the class survey [here](https://docs.google.com/a/berkeley.edu/forms/d/1LWuhIdR8_y7FX2WeI5wAlwX2vDeaPo1E5ghAeUHUEBs/viewform).

Plese set up your machine according to [these instuctions](setup.html).

## Grading

* Class Participation and in-class labs: 20%
* Midterm: 20%
* Final Project (in groups): 25%  Final Project Information is [Here](finalproject.html)
* Homeworks : 30%  (3 @ 10% each: <a href="http://goo.gl/Pkku0e">Homework 1</a>; 
                                  <a href="http://goo.gl/Jpneux">Homework 2</a>; Homework 3)  
* "Bunnies" : 5%

## Schedule

<table class="table table-striped">
  <thead>
    <tr>
      <td><b>Class Date</b></td>
      <td><b>Lecture Material</b></td>
      <td><b>Reading</b></td>
      <td><b>Assignments</b></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>M 1/27</td>
      <td>L1: Introduction/Data Science Process
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfWi1XNTBpVXh5Vms/edit?usp=sharing">[PPTX]</a>
        
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfajJPcURYcTJHekk/edit?usp=sharing">[PDF]</a>
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>M 2/3</td>
      <td>L2: Data Preparation  (w/Unix Shell Lab)
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfYjQ5d0pzTDRFR0k/edit?usp=sharing">[PPTX]</a>
        
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfN24xejYyc1JCMkk/edit?usp=sharing">[PDF]</a>
      </td>
      <td><a href="http://vis.stanford.edu/files/2012-EnterpriseAnalysisInterviews-VAST.pdf">Enterprise Data Analysis and Visualization: An Interview Study</a></td>
      <td>
        <a href="http://goo.gl/SqDnW6">Bunny 1</a> by 5pm on 2/3
        <br>
        <a href="https://github.com/amplab/datascience-sp14/tree/master/lab1">Lab 1</a>
        <!-- | <a href="http://goo.gl/VPhVGW">Responses</a> -->
      </td>
    </tr>
    <tr>
      <td>M 2/10</td>
      <td>L3: Tabular Data (w/Pandas Lab) 
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfOHRmTkxQYmhWdHM/edit?usp=sharing">[PPTX]</a>
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfR1BPeFlETndrLXc/edit?usp=sharing">[PDF]</a>
      </td>
      <td><a href="http://www.eecs.berkeley.edu/~franklin/Papers/dataspaceSR.pdf">From Databases to Dataspaces: A New Abstraction for Information Management</a>
        <br>
        <a href="http://hadapt.com/schemaless-sql-overview/">Schemaless SQL</a> and <a href="http://www.youtube.com/watch?v=cfEYEah1XMg">Schema on Write vs. Schema on Read</a>
      </td>
      <td>
        <a href="http://goo.gl/X6ASom">Bunny 2</a> by 5pm on 2/10
        <br>
        <a href="https://github.com/amplab/datascience-sp14/tree/master/lab2">Lab 2</a>
        <!-- | <a href="http://goo.gl/FdlCwM">Responses</a> -->
      </td>
    </tr>
    <tr>
      <td>F 2/14</td>
      <td></td>
      <td></td>
      <td><a href="http://goo.gl/Pkku0e">Homework 1</a> out. Due by 2/28</td>
 
    </tr>
    <tr>
      <td>M 2/17</td>
      <td>No class - President's Day</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>M 2/24</td>
      <td>L4: Data Cleaning (w/Open Refine Lab)
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfR1RrSWwwbDNrVkk/edit?usp=sharing">[PPTX]</a>
      <a href="https://drive.google.com/a/berkeley.edu/file/d/0B5q5EyRrPiIfcENuLWE2UTlPMEk/edit?usp=sharing">[PDF]</a>
      </td>
      <td>
      </td>
      <td>
        <a href="https://github.com/amplab/datascience-sp14/tree/master/lab3">Lab 3</a>
        <!-- | <a href="http://goo.gl/fyzN4G">Responses</a> -->
      </td>
    </tr>
    <tr>
      <td>F 2/28</td>
      <td></td>
      <td></td>
      <td><a href="http://goo.gl/Pkku0e">Homework 1</a> Due! Submit using glookup</td>
    </tr>
        <tr>
      <td>M 3/3</td>
      <td>L5: Part 1 - Guest Lecture: <a href="http://www.linkedin.com/pub/josh-wills/0/82b/138">Josh Wills, Director of Data Science, Cloudera</a>; followed by: 
      <br>
      Part 2- Data Integration (w/Pandas)
       <a href="http://goo.gl/Ytri9e">[PPTX]</a>
       <a href="http://goo.gl/p6SGyA">[PDF]</a>
       </td>
      <td><a href="http://yz.mit.edu/papers/webtables-vldb08.pdf">WebTables: Exploring the Power of Tables on the Web (Sections 1,2 and 4; others optional)</a>
        <br>
        and <a href="http://www.youtube.com/watch?v=5tsyz3ibYzk">OpenRefine Data Augmentation (video)</a>
      </td>
      <td>
      <a href="https://docs.google.com/a/berkeley.edu/forms/d/1iJNN8LVeqJl2fAZhdKuhbQWWWS31Sz18GlocQozOXSQ/viewform">Bunny 3</a> by 5pm;
      <br> <a href="http://nbviewer.ipython.org/github/amplab/datascience-sp14/blob/master/lab4/joins.ipynb">Lab 4</a> 
      <!-- | <a href="http://goo.gl/ZgfzAN">Responses</a> -->
      <br> <a href="http://goo.gl/YFnAmH">Final Project Group Lists</a> Due Midnight 
      </td>
    </tr>
    <tr>
      <td>M 3/10</td>
      <td>L6: Exploratory Data Analysis (with Python lab)
       <a href="http://goo.gl/8w8Mkb">[PPTX]</a>
       <a href="http://goo.gl/rikI8i">[PDF]</a>
      </td>
      <td><a href="http://proquest.safaribooksonline.com/9781449363871/_statistical_thinking_in_the_age_of_big_data_html">Statistical Thinking in the Age of Big Data</a>
      <br><a href="http://proquest.safaribooksonline.com/9781449363871/_exploratory_data_analysis_html">Exploratory Data Analysis</a><br>
      From the O'Reilly Book "Doing Data Science" - available on campus or via the library VPN.<br><br>
      <a href="http://www.sagepub.com/upm-data/40007_Chapter8.pdf">Introduction to Hypothesis Testing</a>
      </td>
      <td><a href="http://goo.gl/tiHqU2">Bunny 4</a> by 5pm;
      <br><a href="http://nbviewer.ipython.org/github/amplab/datascience-sp14/blob/master/lab5/lab5.ipynb">Lab 5</a>
      <!-- | <a href="http://goo.gl/ZDS8Rb">Responses</a> -->
      <br>Final Project Proposals due Tues 3/11 Midnight.</td>
    </tr>  
    <tr>
      <td>T 3/11</td>
      <td></td>
      <td></td>
      <td><a href="http://goo.gl/Jpneux">Homework 2</a> out. Due by 4/1</td>
    </tr>
    <tr>
      <td>M 3/17</td>
      <td>L7: Regression, Classification, intro to Supervised Learning (with R Lab)<br>
        Part 1:<a href="http://goo.gl/WKx4jz">[PPTX]</a> <a href="http://goo.gl/8EFuWI">[PDF]</a>
        Part 2:<a href="http://goo.gl/GNnU8i">[PPTX]</a> <a href="http://goo.gl/CGgRY7">[PDF]</a><br>
        <a href="http://goo.gl/Hh6CwR">Homework Tips</a>
      </td>
      <td><a href="http://proquest.safaribooksonline.com/book/databases/9781449363871/3dot-algorithms/_three_basic_algorithms_html"> Three Basic Algorithms</a>
      From the O'Reilly Book "Doing Data Science" - available on campus or via the library VPN.<br>
      </td>
      <td><a href="http://goo.gl/y4IvKu">Bunny 5</a> by 5pm <br>
          <a href="https://github.com/amplab/datascience-sp14/tree/master/lab6">Lab 6</a> 
          <!-- | <a href="http://goo.gl/7kUpAb">Responses</a> --> 
      </td>
    </tr> 
    <tr>
      <td>M 3/24</td>
      <td>No Lecture: Spring Break</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 3/31</td>
      <td>L8: Part 1 - Guest Lecture: <a href="http://www.linkedin.com/in/peterskomoroch">Peter Skomoroch</a>; Slides: <a href="http://goo.gl/NbQxvE">[PDF](29MB)</a>; followed by:
      <br>
        Part2 - <a href="http://goo.gl/e50eqQ">Unsupervised Learning and K-Means Clustering </a> (in Python)
      </td>
      <td>K-Nearest Neighbors and K-Means clustering from <a href="http://proquest.safaribooksonline.com/book/databases/9781449363871/3dot-algorithms/_three_basic_algorithms_html"> Three Basic Algorithms</a>.
      Part of the O'Reilly Book "Doing Data Science" - available on campus or via the library VPN.<br>
      </td>
      <td>No Bunny ! <br> 
          <a href="http://goo.gl/nzDvVk">Lab 7</a>
          <!--| <a href="http://goo.gl/PKUQio">Responses</a> -->
      </td>
    </tr> 
    <tr>
      <td>T 4/1</td>
      <td></td>
      <td></td>
      <td><a href="http://goo.gl/Jpneux">Homework 2</a> Due. Submit using glookup</td>
    </tr>
    <tr>
      <td>M 4/7</td>
      <td>L9: Scaling Up Analytics (with Spark/EC2 Lab); Guest Lecturer: <a href="http://www.eecs.berkeley.edu/~keo/"> Kay Ousterhout</a> <a href="http://goo.gl/l4Stce">[PDF]</a> <a href="http://goo.gl/M23eAE">[PPTX]</a></td>
      <td>"MapReduce," "Word Frequency Problem", and "Other Examples of MapReduce" sections from O'Reilly "Doing Data Science" book (available <a href="http://proquest.safaribooksonline.com/book/databases/9781449363871/14dot-data-engineering-mapreduce-pregel-and-hadoop/_mapreduce_html"> online</a> or from the library) and <a href="http://people.csail.mit.edu/matei/papers/2010/hotcloud_spark.pdf">Spark Short paper</a></td>
      <td><a href="http://goo.gl/Q4S856">Bunny 9</a> by 5pm <br> <a href="http://goo.gl/Y1Bom6"> Lab 8 </a> <br>
          <a href="http://goo.gl/gYtoVf">Homework 3, Part 1</a> Due 4/14</td>
    </tr> 
    <tr>
      <td>F 4/11</td>
      <td></td>
      <td></td>
      <td>Final Project update due on glookup</td>
    </tr> 
    <tr>
      <td>M 4/14</td>
      <td>
          L10: Visualization (D3 lab)<a href="http://goo.gl/LWNBKw">[PPTX]</a> <a href="http://goo.gl/RKEsCP">[PDF]</a><br>
          <a href="https://speakerdeck.com/alignedleft/learning-d3">Lab Slides</a>
      </td>
      <td>
        <a href="http://proquest.safaribooksonline.com/book/databases/9781449363871/9dot-data-visualization-and-fraud-detection/ch09_html">Chapter 9 on Data Visualization</a> from "Doing Data Science" available online or from the library.<br>
        <a href="http://vis.stanford.edu/files/2011-D3-InfoVis.pdf">D3: Data Driven Documents</a> by Bostock et. al.<br>
        Optional: <a href="http://goo.gl/Dx43fc">Reading about how the challenger disaster may have been prevented with data visualization</a> by Edward Tufte<br>
      </td>
      <td>
          <a href="http://goo.gl/FPYhKm">Bunny 10</a> by 5pm<br>
          <a href="http://goo.gl/gYtoVf">Homework 3, Part 1</a> due<br>
          <a href="http://nbviewer.ipython.org/github/amplab/datascience-sp14/blob/master/lab9/lab9.ipynb">Lab 9</a>
      </td>
    </tr> 
    <tr>
      <td>Th 4/17</td>
      <td></td>
      <td></td>
      <td>Midterm - 6.00 to 7.30 pm</td>
    </tr> 
    <tr>
      <td>F 4/18</td>
      <td></td>
      <td></td>
      <td><a href="http://nbviewer.ipython.org/github/amplab/datascience-sp14/blob/master/hw3/hw3-part2.ipynb">Homework 3, Part 2</a> out.  Due by 4/25.</td>
    </tr> 
    <tr>
      <td>M 4/21</td>
      <td>L11: Graph Processing (with GraphX Lab); Guest Lecturers: <a href="http://www.cs.berkeley.edu/~jegonzal/">Joey Gonzalez</a> and <a href="https://github.com/dcrankshaw">Dan Crankshaw</a>  <br>
      <a href="http://goo.gl/J1MeuJ">[PPTX]</a>(19MB) <a href="http://goo.gl/Xb87gO">[PDF]</a>(19MB)<br>
      </td>
      <td><a href="https://www.cs.cornell.edu/home/kleinber/networks-book/networks-book-ch02.pdf">Chapter 2</a> from "Networks, Crowds, and Markets: Reasoning About a Highly Connected World"
      </td>
      <td>
        <a href="http://goo.gl/WnPMZG">Bunny 11</a> by 5pm<br>
        <a href="http://goo.gl/MNC56V">Lab 10</a> <!-- | <a href="http://goo.gl/VzFGkH">Responses<a/> -->
      </td>
    </tr>
    <tr>
      <td>F 4/25</td>
      <td></td>
      <td></td>
      <td><a href="http://nbviewer.ipython.org/github/amplab/datascience-sp14/blob/master/hw3/hw3-part2.ipynb">Homework 3, Part 2</a> due</td>
    </tr> 
    <tr>
      <td>M 4/28</td>
      <td>L12: Putting it All Together</td>
      <td></td>
      <td><a href="http://goo.gl/PoLg6p">Bunny 12</a> by 5pm</td>
    </tr> 
  </tbody>
  </tbody>
</table>
