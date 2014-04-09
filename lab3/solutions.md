# Automated Data Cleaning with OpenRefine and Exploratory Data Analysis

So far in this class, we've looked at command-line data cleaning with UNIX utilities, and a bit of structured data analysis with Pandas.
In Homework 1, you're looking at a Data Integration problem - namely, entity resolution.
As we've seen already, data cleaning is an unpleasant, often repetitive task.
Fortunately, there are a number of modern tools that make this task easier, one of which we'll look at today using an example dataset.

Once your data is cleaned and integrated, you'll want to start the process of *analyzing* it. 
One good way to start an analysis is using a family of techniques collectively referred to as *Exploratory Data Analysis*.
Once we've cleaned up our sample dataset, we'll look at a few of these techniques and see if they help suggest hypotheses we may want to test with the data.

## Getting The Dataset

We'll be working with a dataset that contains a record of natural disasters worldwide since 1900. It contains information about when a disaster happened, what kind of disaster, where in the world it was, and how many people were affected or killed by it, in addition to estimated cost.

On your VM, go [here](http://www.infochimps.com/datasets/disasters-worldwide-from-1900-2008) and download and unzip the dataset to a new folder in your home directory, called "datasets". If you download with Firefox, the file will be saved to ~/Downloads. When your'e done, you should have a directory that looks something like this.

    saasbook@saasbook:~/datasets/infochimps_dataset_12691_download_16174$ ls -altr
    total 1644
    -rw------- 1 saasbook saasbook    3730 2010-02-09 14:50 SCHEMA.txt
    -rw-r--r-- 1 saasbook saasbook     908 2010-02-09 14:50 README-infochimps
    -rw-r--r-- 1 saasbook saasbook    7821 2010-02-09 14:50 infochimps_dataset_12691_download_16174.icss.yaml
    -rw------- 1 saasbook saasbook 1656312 2010-02-09 14:50 emdata.tsv
    drwxrwxr-x 3 saasbook saasbook    4096 2014-02-23 17:18 ..
    drwxrwxr-x 2 saasbook saasbook    4096 2014-02-23 17:18 .

## Installing OpenRefine

[OpenRefine](http://openrefine.org/) (formerly Google Refine) is an open source tool to automate data cleaning on small to medium datasets and works well on datasets that are up to a few hundred thousand rows.

It contains several advanced features for data cleaning - some of which we'll use, but many of which we won't touch. You'll notice that the branding and filenames still say Google on them - this will change in version 2.6, which is currently in beta.

Download OpenRefine to your VM and launch it (you'll need to install the java runtime first):

    sudo apt-get install openjdk-7-jre-headless
    mkdir ~/refine/
    cd ~/refine/
    wget https://github.com/OpenRefine/OpenRefine/releases/download/2.5/google-refine-2.5-r2407.tar.gz
    tar zxvf google-refine-2.5-r2407.tar.gz
    ./google-refine-2.5-r2407/refine

This whole process will take a few minutes, so while it's running, let's watch an [intro video](http://www.youtube.com/watch?v=B70J_H_zAWM).

Once that's done, you can open your web browser and navigate to http://127.0.0.1:3333/ to access the tool.

## Importing The Dataset

OpenRefine supports importing data in several formats, but luckily our file is already a well formatted data table.
Loading it up should be no problem!

From the "Create Project" tab, select 'Choose Files' and select the file 'emdata.tsv' from the directory that contains your dataset.

OpenRefine will show you a preview of your dataset - it should look ok, so select 'Create Project'.

### DIY

1. Import the file "emdata.tsv" from the InfoChimps data directory into OpenRefine. There's a "Create Project" button when you're done.


## Facets and Filters

The workflow in OpenRefine is observe, filter, change, repeat.
A central concept in the system is the idea of a "Facet". 
You can think of a facet as a knob you get to play with to determine which data rows to show.
This knob is conditioned on data in one ore more columns.
These knobs can be combine to form complex filters on your dataset.

Once data is selected, you can edit it *en masse*. If there's a transformation you want to apply, you can apply it to all the data that matches the current selection.

Importantly, once you've selected items within a facet, any changes you make are only applied to the current selection!

OpenRefine has several facet types. Click the arrow above "Type" and select "Text Facet" from the "Facets" menu.

A new facet will appear on the left - with a bunch of disease types in it. Click on a few and observe what happens in the main screen.
When you're done with it, click "Reset" in the facet.

Do you notice anything unusual about the items on this list? (Duplicates?)

### DIY
1. Create a Text Facet for the "Type" field. **SOLUTION**: *Click the arrow next to 'Type', then click Facet -> Text Facet*
2. Change the sort order from name to "Count" - what is the most common type of disaster? **SOLUTION**: *In the filter that shows up, select 'Sort by: Count'. Transport Accident should be most common.* 

## Cleaning Text Data

As we saw with our text facet, there's dirty data here!
But, how do we use the tool to clean this up?
There are a number of ways to clean text data in OpenRefine. We'll cover two common ways.

*If you make a mistake, don't worry, OpenRefine keeps a full history of everything you've done - you can always go back and undo changes that were wrong.*

### Direct Editing in Facet
For common one-off cases, as in the case of typos or case mismatch issues like the one we saw above, we can just edit those values directly.
Click "Edit" next to "Mass Movement Wet" on the left side - we want to assign this to the more common case "Mass movement wet".
In this case, simply changing the string suffices.
Look at the count of "Mass movement wet" in the type facet - it's gone up!
This is because the values have now been merged.

### Cluster Editing
This kind of manual editing can get pretty tedious, even if you're updating hundreds of rows at once.
Also, it introduces the possibility for human error - what if "Mass movement wet" had been written "Bass movement wet" - we likely never would have caught this.

Luckily, OpenRefine offers a feature to address this called "Clustering" - click the "Cluster" button above the Type facet to start this feature. If cluster doesn't show anything, try again after clicking "reset" on the 

It automatically caught two additional duplicates in this column, and if you select all the proposals and click "Merge Selected and Close", the transformations will happen for you automatically.

This feature is quite powerful and supports other kinds of "Clustering" functions - it even has the ability to cluster based on the way the values "sound" with phoenetic clustering - this works particularly well for the names of people or places that come from languages other than English that are then translated to English multiple ways.

#### DIY
1. Make sure you've cleaned up the 'Type' field.  **SOLUTION**: *You should clean up three clusters in the 'Type' field.*
2. Try cleaning the "Country" and "Name" fields in the same way. **SOLUTION**: *You should clean up one cluster in the 'Country' field and several (around 50) in the name field. You may have to increase a setting in your facets to cluster names.*

## Cleaning Numeric/Date Data

Look at the "Start" and "End" columns in the current display - they're kind of weird, aren't they? They're numbers, but they kind of look like dates. But then again, they don't have a consistent format.

It turns out that they're not so straightforward to convert to dates - some are YYYY, some are MMDDYYYY, some MMYYYY, and some are outright errors.

We could have refine filter these and create dates out of all of them, but for lack of time here, we're going to take a short cut and just get the years.
So, in the "Start" and "End" columns, we just want to select the last 4 characters of the column and make it a number.
But, how do we do that?

### GREL

Luckily, OpenRefine has its own programming language for just such a task, called Google Refine Evaluation Language - or GREL.
Thankfully, the language isn't particuarly complicated, and is pretty well described [here](http://co-synergy.com/GREL%20Quick%20Reference.pdf).
Additionally, it's possible to use Jython or Clojure to do the transformation as well, but we'll stick with GREL for the next few examples.

### Cleaning Those Dates

First, make sure all your facets have been reset (click "Reset All" on the left).

Now, select the arrow next to "Start", and select "Edit Cells" -> "Transform".
Here you'll see an "Expression" input box and a preview output.
OpenRefine lets you preview the effect of your transformations on the fly.


In the Expression box, there is the word `value` - this is the name of the object that contains the current value of the cell being transformed.
Enter `value.length()` - the preview should show you the length of those strings.
Now try `value.slice(2)` - what happens now?

Can you come up with an expression for the last four characters of this string?

Finally - we want our result to be a number, but the result of `.slice()` is a string. Use `.toNumber()` to convert your final answer to a number.

#### DIY
1. Transform the "Start" column to just the year portion of the field, using the method above. **SOLUTION**: *The expression is toNumber(value.slice(length(value)-4))*
2. Do the same for the "End" column. **SOLUTION**: *Same as above. Use the History tab instead of copying and pasting.*

### Derived Columns

Once you've got start and end columns as numbers, we'd like to be able to focus on records for just the really *long* natural disasters. 
You could do this with a scatterplot facet (which is insanely cool, BTW), or, you could do it with a derived column.
We'll calculate a derived column that we'll call "Duration" that is the end time of the event minus the start time.

To create a derived column, select the "End" column, select "Edit Column" -> "Add Column Based on This Column"

In our case, we'll want a column that combines information from two columns. In the GREL expression evaluation environment, an object called `cells` is exposed.
Cells is a dictionary that allows you to look up any cell in the current row. To get a value in another column, the syntax is `cells["ColumnName"].value`.

Given this, you should be able to create a "Duration" column.

#### DIY
1. Create a "Duration" column which contains the difference between End and Start. **SOLUTION**: *The expression is: value - cells["Start"].value*
2. Create a facet on duration. Filter to rows which have a Duration above 2 years. What kind of disaster is most common?  **SOLUTION**: *The most common disaster that lasts more than two years is 'Drought'. You can see this in the "Type" facet.*

## Provenance, Repeatability, and External Integration

As we mentioned, OpenRefine supports full history of everything you've done. 
This is important to support an idea referred to as [data provenance](http://en.wikipedia.org/wiki/Provenance#Data_provenance) - that is, we can trace our derived data back to our base data.

It also means that the process of transforming/cleaning the data is *repeatable*, on this dataset or a new one that looks like it. 
This means we can use refine to automate a lot of this nasty data cleaning work - do it once and forget it!

Finally, OpenRefine supports calling out to webservices as part of its cleaning process. 
This means that we can pretty easily integrate data from other sources all in this tool.
More on external integration next week!

# Exploratory Data Analysis

Exploratory data analysis (EDA) is the process of summarizing datasets to help understand their main characteristics. 
It's an approach that was championed by [John Tukey](http://en.wikipedia.org/wiki/John_Tukey) and led directly to the development of the S (and later R) programming languages, and indirectly to environments like pandas and iPython - that is, the tools you're using are *built* for EDA.

The collection of tools used to perform EDA is large and we will cover more of them later in the class, but for today, we're going to look at two of them - summary statistics and histogramming.

You've already seen both of these in the last class - but this time we'll go into a little more depth and see how we can can use these tools to better "get to know" our data.

## Loading Our Cleaned Dataset

In OpenRefine, export your dataset to a csv file using the "Export" button at the top right.
If you haven't changed your project name, it will be saved to a file called `~/Downloads/emdata-tsv.csv`.

Now, fire up an ipython notebook with the command `ipython notebook` from the terminal.

In a new notebook, import pandas and load your dataset.

    %matplotlib inline
    import pandas as pd
    data = pd.read_csv("~/Downloads/emdata-tsv.csv")
    
Next, make sure you understand the basic properties of your data - its size and shape, etc.

    data.describe()
    data.shape
    data.Country.describe()
    data.Type.describe()

### DIY
1. Make sure you've loaded your cleaned dataset.
2. Given the output of above - what's the largest number of people killed by a single disaster? **SOLUTION**: *5000000 is the max value for Killed in the output of data.describe().*

## Digging into Conditional Distributions
Knowing the summary statistics for our whole dataset is great, but what if we want to know summary statistics for a field by disaster type?

Pandas makes that really easy with the split/apply/combine strategy we talked about last time. 
Try the following command:

      data.Cost.groupby(data.Type).describe().unstack().sort(columns='mean')
    
What have we done here? We've taken the cost column and grouped it by type. 
We've then applied the summary statistics to each group and called "unstack" which just reshapes the result for us to make things a little more readable.
Finally, we've sorted by the 'mean' column - this tells us the average cost of a given disaster by type.

At the top, we see that traffic accidents are least costly. At bottom, we see that Drought is most costly.

### DIY
1. Come up with an expression to compute the total # of people killed by Type - which is highest? Second highest? **SOLUTION**: *Drought is highest, epidemic second highest. print data.Killed.groupby(data.Type).sum().order()*

## Plotting Distributions and Seeing Relationships
Now let's look at some plots of our data to understand it better. We'll look at two tools here, but there are many more.

### Box Plots
Box plots are a visual representation of the same kind of information that we saw in our descriptive statistics.
Namely, they let us look at things like mean, median, min, max, and IQR (middle 50%) of some set of data.
They also show outliers.

Try these commands out:

    ax = data.boxplot(column='Cost', by='Type', figsize=(12,12), rot=90, grid=False)
    ax.set_yscale('log')
    
With these commands we're plotting cost by type and seeing the results visually.
*Note, because of the heavy skew in the data, we've plotted on a log scale.*

### Scatter Matrixes
A scatter plot matrix is a powerful tool to help you identify relationships between pairs of columns in your dataset.

Try this command in your notebook:

    _  = pd.scatter_matrix(data[['Cost','Killed','Affected','Duration']], figsize=(12,12))

Here, we're plotting the relationships between Cost, Killed, Affected, and Duration across the whole dataset.
Do you notice any patterns?

#### DIY
1. Write down a pattern you see when looking at the dataset visually that wasn't previously evident. **SOLUTION**: *Commenting on which values seem to be discrete and which are continuous, the heavy distribution near zero but long tail of many of the scatter plots, etc, are all good observations.*
