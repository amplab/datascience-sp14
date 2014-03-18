# Linear Regression using R

In this lab exercise we will learn about [R](http://r-project.org), a popular
tool for data analysis and we will use R to do some basic linear regression.
Many of the data frame features, plotting routines and machine learning
algorithms that we use in Pandas or scikit-learn are also supported in R.

> Before you start, make sure you install R. You can do this in your VM by running
> `sudo apt-get -y install r-base`

Remember to fill out the response form at http://goo.gl/7kUpAb !

## Introducing R

R is both a programming language and a software environment and is primarily targetted
at doing statistical computing. In the first part of the exercise we will look at 
the basics of R and also play around with data frames and compare it to Pandas.

### Basics of R
To launch R, run `R` from a command line. That will open the R shell. This is similar to the
python (or ipython) shells we have previously used in class. 

Lets get familiar with R by trying out some simple commands:

* **Assignment**: You can assign values to a variable using either `<-` or `=`. They are equivalent
but the `<-` notation is usually preferred.
```
  x <- 10
  y = 5
  x+y
```
* **Vectors, Matrices**: R has native support for vectors and matrices. We will create a matrix and a vector
below and multiply them.
```
  m <- matrix(nrow=5, ncol=2, data=1.0)
  v <- c(1.5, 0.5)
  r <- m %*% v
  z
```
* **Printing variables**: To print a variable, just type in the variables name !
* **Mathematical operations**: R includes a number of mathematical operators such as log, exp etc.
```
  log(x)
  exp(y)
```
* **Getting Help**: If you want to figure out what a R function does, you can lookup the help manual
by typing `?<function_name>`. For example if we want to read up about `log` we can run `?log`. 
If you want to search for a function that does something you can run `??<search_string>`. For example
searching for `??log` will return all the functions that include the word `log` in their help text. NOTE:
you can exit from the help screen by pressing `q`.
```
  ?log
  ??log
```

### DataFrames in R
Similar to Pandas, R also has excellent support for DataFrames. We will look at R commands to do some of
the basic data frame operations.

#### Reading in data to create a dataframe.
R provides helper functions to read in a csv and other tabular data files. To get an idea of how they work
read in the `nyt1-sample.csv` provided using the `read.csv` command.

```
   nyt1 <- read.csv("./nyt1-sample.csv")
   nyt1
```
You can see other arguments that can be passed to read.csv using `?read.csv` and `read.table`.
#### Summarizing data frames
Similar to Pandas, R also supports functions to quickly summarize a data frame. These include functions
like `head`, `tail` to print the first few or last few rows of the data frame. You can use `dim` to get
the dimensions of a data frame. Try these out on `nyt1`.

You can also get a quick summary of numerical columns using the `summary` function. Keep this function
in mind as we will be using this later on as well !
```
  head(nyt1)
  tail(nyt1)
  dim(nyt1)
  summary(nyt1)
```

#### Selecting rows, columns
To select a subset of rows or columns of a data you can index into the rows and columns of the data frame.
For example to select a subset of rows, try the following commands:

```
  nyt1[1:2,]
  nyt1[3:10,]
```
To select a column you can either index into the columns or you can use the `$` notation to get a single
column. Try the following commands to get an idea of how column selection works:
```
  nyt1$Age
  nyt1[, "Age"]
  nyt1[, c("Age", "Gender")]
```
Of course you can combine the above steps and select some subset of rows, columns. To get the Age and
Gender column from the first five rows you can run something like
```
  nyt1[1:5, c("Age", "Gender")]
```

### DIY
* Select all the rows and the columns 'Impressions' and 'Clicks'. Optional question: How do we use 
these to compute the CTR (click through rate) ?

## Exploring and plotting data in R

Next we take a whirlwind tour of exploring data and plotting data in R. First we will load a motor cars
dataset that is provided in a package called `datasets`.

### Loading R packages, datasets
To load a package in R, you can use `require(<library_name>)`. The dataset we are interested in is 
provided by a package named `datasets`. Run `require(datasets)` to load this package. Note: R has a 
large number of add-on packages that provide high level functions for commonly used functions. To see
a listing of available packages you can look at the 
[CRAN package list](http://cran.cnr.berkeley.edu/web/packages/available_packages_by_name.html).

The dataset we will be using is called `mtcars` (for motor cars). To get an idea of what the dataset is
about, run `?mtcars`. This will show a help page that describes the schema. You can also use `head`,
`summary` etc. to get an idea of how the dataset looks.

Finally we will `attach` the dataset in our environment. What this means is that the dataset is added 
to our working environment (Its something like `from package import *` in python). After attaching the
dataframe all its column names are added as variables to our environment. Try the following commands to
get an idea

```
  attach(mtcars)
  head(mtcars)
  mpg
```

### Basics of plotting
R also has extensive support for plotting in its base packages and more complex plots are supported by
add-on packages like [ggplot2](http://ggplot2.org/). We will take a look at some of the basic plotting
functions below

* **Histograms**: To plot a histogram you can use the `hist` function. For example try the following commands:
```
  hist(mpg)
  hist(mpg, breaks=10)
```

* **Scatter plots**: For scatter plots you can use the `plot` command and pass in the `x` and `y` values as
arguments. For example to plot a scatter plot of miles per gallon (mpg) vs. gears (gear) you can do 
something like
```
  plot(mpg, gear)
```
* **Line plots**: Line plots are similar to scatter plots except you may just want to use a sequence of numbers
on the x axis. For example to plot the mpg across different cars you can try the following commands.
```
  plot(1:length(mpg), mpg)
  plot(1:length(mpg), mpg, type="l")
  plot(1:length(mpg), mpg, type="b")
```

###DIY
* Plot a scatter plot of mpg vs. weight. Also plot a histogram of the weights. What value for weight
occurs most frequently ? How many times does it occur ?

## Linear Regression in R
In this part of the assignment we will look at how to do linear regression using R. The problem we will be 
consider here is:

>*Can we predict the miles per gallon of a car based on the other features ?*

In this problem setting miles per gallon (mpg) is our response variable while all other columns are features
we could use in our model.

## Simple Linear regression

In the first step we will do a simple linear regression where we consider just one feature: 
horsepower (hp).

### Scatter plot
First to see if we have a linear relation or not, lets do a scatter plot of mpg vs. hp
```
  plot(mpg, hp)
```
From the plot we can see that we have something that looks like a linear relationship.

### Linear regression
Lets run linear regression using R to fit a model for this problem. To do this we can run

```
  model_hp <- lm(mpg ~ hp)
  summary(model_hp)
```
In the first line the `~` operator separtes the response variable from the features and
is called as the `formula` for the regression. The summary prints a lot of useful
information about the model. Lets look at a few of them in detail

1. The first line gives you the distribution of the residuals using Min, Median etc.
As you might recall from the reading minmizing residuals is the goal of regression, so
these values should hopefully be small.

2. The next section shows the coefficients for different parts of our model. In our case
we have two coefficients as we are trying to fit `y = ax + b` where y is mpg and x is hp.
The term `b` is called the intercept. We see the estimated value for each coefficient
in the output. Along with the estimated value, R also prints the standard error. This
represents variability present in our estimate. A lower value is better. 

3. The last column of the co-efficients section shows significance stars for each 
coefficient. These stars represent how confident we are that the variable is relevant
for linear regression. Three stars means the variable is useful !

4. The p-value in the column before the stars is the probability that the variable is NOT
relevant.

5. Two lines below this the R^2 values is shown. Recall that the value of R^2 is the 
proportion of variance that is explained by our model. Higher R^2 values are better.

### Plotting our model

Next lets plot our data points and our model to see how well it fits. To do this run
the following commands
```
  plot(hp, mpg)
  abline(model_hp$coefficients)
```

However plotting the model alone is not always useful. It is more useful to see
the values of our residuals and see how the residuals vary for different values of data.
One of the commonly used plots for this is 'Residuals vs. Fitted'. Recall that fitted 
values are points in the predicted line closest to the observed data. Residuals represent
the distance between the observed and fitted values.

To get a residuals vs. fitted plot you can run the following commands
```
  plot(fitted(model_hp), residuals(model_hp))
  abline(h=0, lty=2)
```

Finally recall that we assume the error terms in our linear regression are normally
distributed. We can verify that by using what is called a QQ plot. In a QQ plot we plot
the distribution of the residuals against the CDF of the normal distribution. If we 
see a points close to the diagonal this means our assumption is valid. To get a QQ plot
we can run
```
  qqnorm(residuals(model_hp))
  qqline(residuals(model_hp))
```

### Adding features to our model
As we can see from the above diagnostics, our simple model does not fit the data very 
well. We can try to augment our model with more variables to see if things improve. Lets
add `weight` to our model and repeat the above steps.

```
  model_hp_wt <- lm(mpg ~ hp + wt)
  summary(model_hp_wt)
  plot(fitted(model_hp_wt), residuals(model_hp_wt))
  abline(h=0, lty=2)
```
Does the residuals vs. fitted plot look any different ? What about the R^2 values ?

```
  qqnorm(residuals(model_hp_wt))
  qqline(residuals(model_hp_wt))
```

###DIY
* Fit a model `model_all` that includes all the features in our dataframe `mtcars`. How
much does the value of R^2 change ? What about R^2 adjusted ?


## Transforming variables in linear regression
Sometimes the R^2 values are not sufficient to judge if we have a good model. To see
this we will use the [Anscombe](http://en.wikipedia.org/wiki/Anscombe's_quartet) dataset. You can check out the data by running
```
  anscombe
```

There are 4 columns for X x1, x2, x3, x4 and 4 columns for Y: y1, y2, y3, y4. In this
exercise we will only compare linear regression for (x1, y1) vs. (x2, y2). 

First plot a scatter plot of x1 vs. y1 and x2 vs. y2 to get an idea of how the data looks.
```
plot(anscombe$x1, anscombe$y1)
plot(anscombe$x2, anscombe$y2)
```

We can see that x1 vs. y1 looks like linear but x2 vs. y2 does not

Now fit a linear model for both and compare the R^2 values.

```
  lm1 <- lm(y1 ~ x1, data=anscombe)
  summary(lm1)
  lm2 <- lm(y2 ~ x2, data=anscombe)
  summary(lm2)

```

### DIY
* Plot the fit lines for both datasets. What do you see ?

To get a better fit for the second case we can use x^2 as our regression variable. Now
this may seem confusing as it looks like we are doing quadratic regression now rather than
linear regression. That is not the case as we are just treating x^2 as a new variable say
'Z' and we are using 'Z' as our linear input variable now.

```
  lm_sq <- lm(y2 ~ poly(x2, 2), data=anscombe)
  summary(lm_sq)
```

### DIY
* Plot the residuals vs. fitted values and qqnorm for lm_sq and lm2. What are some
of the differences ?

Remember to fill out the response form at http://goo.gl/7kUpAb !
