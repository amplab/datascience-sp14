* Select all the rows and the columns 'Impressions' and 'Clicks'. Optional
question: How do we use  these to compute the CTR (click through rate) ?
```
nyt1[, c("Impressions", "Clicks")]
nyt1[,"CTR"] <- nyt1[, "Clicks"] / nyt1[, "Impressions"]
```

* Plot a scatter plot of mpg vs. weight. Also plot a histogram of the weights.
 What value for weight occurs most frequently ? How many times does it occur ?

```
plot(mpg, wt)
hist(wt, breaks=100)
```
The weight that occurs most frequently is 3.4 and it occurs 4 times


* Fit a model `model_all` that includes all the features in our dataframe
 `mtcars`. How much does the value of R^2 change ? What about R^2 adjusted ?

```
model_all <- lm(mpg ~ ., data=mtcars)
summary(model_all)
```
Value of R^2 for model_all is 0.869, adjusted R^2 is 0.8066. As you include more
features R^2 will increase, but adjusted R^2 may decrease.


* Plot the fit lines for both datasets. What do you see ?
```
plot(anscombe$x1, anscombe$y1)
abline(lm1$coefficients)
plot(anscombe$x2, anscombe$y2)
abline(lm2$coefficients)
```
The fit is good for the first dataset but not for the second dataset.


* Plot the residuals vs. fitted values and qqnorm for lm_sq and lm2. What are some
of the differences ?
```
plot(fitted(lm2), residuals(lm2))
plot(fitted(lm_sq), residuals(lm_sq))
```

The values of residuals is much lower for lm_sq compared to lm2. Also the fitted
vs. residuals for lm2 has a pattern that suggests errors are not randomly
distributed with a normal distribution.
