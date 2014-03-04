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

* Course Number: CS 194-16, Spring 2014, UC Berkeley
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
* Final Project (in groups): 25%
* Homeworks : 30%
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
        | <a href="http://goo.gl/fyzN4G">Responses</a>
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
      <br> Final Project Group Lists Due Midnight 
      </td>
    </tr>
    <tr>
      <td>M 3/10</td>
      <td>L6</td>
      <td></td>
      <td>Final Project Proposals due Midnight</td>
    </tr>  
    <tr>
      <td>M 3/17</td>
      <td>L7</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 3/24</td>
      <td>No Lecture: Spring Break</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 4/7</td>
      <td>L8</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 4/14</td>
      <td>L9</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 4/21</td>
      <td>L10</td>
      <td></td>
      <td></td>
    </tr> 
    <tr>
      <td>M 4/28</td>
      <td>L11</td>
      <td></td>
      <td></td>
    </tr> 
  </tbody>
  </tbody>
</table>
