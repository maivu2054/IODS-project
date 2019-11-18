#tips: pull first to update rmd 

url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"

# web address for math class data
url_math <- paste(url, "student-mat.csv")

# print out the address
url_math

# read the math class questionaire data into memory
math <- read.table(url_math, sep = ";" , header=TRUE)
View (math)
# web address for portuguese class data
url_por <- paste("replace me!", "student-por.csv", sep =" change me! ")
View (url_por)
# print out the address

# math and por are available

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = "change me!")

# see the new column names


# glimpse at the data
head()
View ()


# read the portuguese class questionaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)

# look at the column names of both data
colnames(math)
# dplyr, math_por, join_by are available

# print out the column names of 'math_por'


# create a new data frame with only the joined columns
dat <- select(math_por, one_of("change me!"))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining


# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the dat data frame
    dat[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the dat data frame
    dat[column_name] <- "change me!"
  }
}

# glimpse at the new combined data

# dat is available

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column dat_use by combining weekday and weekend datohol use
dat <- mutate(dat, dat_use = (Ddat + Wdat) / 2)

# initialize a plot of datohol use
g1 <- ggplot(data = dat, aes(x = dat_use))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
dat <- mutate(dat, high_use = "change me!" > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = dat)

# draw a bar plot of high_use by sex

# dat is available

# access the tidyverse libraries tidyr, dplyr, ggplot2
library(tidyr); library(dplyr); library(ggplot2)

# glimpse at the dat data


# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
gather(dat) %>% glimpse

# draw a bar plot of each variable
gather(dat) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free")

# dat is available

# access the tidyverse libraries dplyr and ggplot2
library(dplyr); library(ggplot2)

# produce summary statistics by group
dat %>% group_by(sex) %>% summarise(count = n())

library(ggplot2)

# initialize a plot of high_use and G3
g1 <- ggplot(dat, aes(x = high_use, y = G3))

# define the plot as a boxplot and draw it
g1 + geom_boxplot() + ylab("grade")

# initialise a plot of high_use and absences


# define the plot as a boxplot and draw it

# dat is available 

# find the model with glm()
m <- glm(high_use ~ failures + absences, data = dat, family = "binomial")

# print out a summary of the model

summary (m)
# print out the coefficients of the model

coef(m)

# find the model with glm()
m <- glm(high_use ~ failures + absences + sex, data = dat, family = "binomial")

# compute odds ratios (OR)
OR <- coef(m) %>% exp

# compute confidence intervals (CI)
CI <- confint (OR)
CI <- confint (coef(m) %>% exp)

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

# dat, dplyr are available

# fit the model
m <- glm(high_use ~ failures + absences + sex, data = dat, family = "binomial")

# predict() the probability of high_use
probabilities <- predict(m, type = "response")

# add the predicted probabilities to 'dat'
dat <- mutate(dat, probability = probabilities)

# use the probabilities to make a prediction of high_use
dat <- mutate(dat, prediction = "change me!")

# see the last ten original classes, predicted probabilities, and class predictions
select(dat, failures, absences, sex, high_use, probability, prediction) %>% tail(10)

# tabulate the target variable versus the predictions
table(high_use = dat$high_use, prediction = "change me!")

# dat is available

# access dplyr and ggplot2
library(dplyr); library(ggplot2)

# initialize a plot of 'high_use' versus 'probability' in 'dat'
g <- ggplot(dat, aes(x = "probability ", y = "hight_use"))

# define the geom as points and draw the plot
g1 <- g + geom_point()
print (g1)
col= prediction
table () 
# tabulate the target variable versus the predictions
table(high_use = dat$high_use, prediction = dat$prediction)

# the logistic regression model m and dataset alc with predictions are available

# define a loss function (mean prediction error)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# call loss_func to compute the average number of wrong predictions in the (training) data
loss_func(class = alc$high_use, prob = 0)

# the logistic regression model m and dataset alc (with predictions) are available

# define a loss function (average prediction error)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# compute the average number of wrong predictions in the (training) data


# K-fold cross-validation
library(boot)
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m, K = nrow(alc))

# average number of wrong predictions in the cross validation
cv$delta[1]







