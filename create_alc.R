#Mai Vu 17 Nov 19
#read both student-mat.csv and student-por.csv into R 

setwd(getwd)
mat <- read.csv(D:/ONE DRIVE/OneDrive - University of Eastern Finland/Attachments/8 statistics/2 R program/r practice/IODS-project/data/"student-mat.csv", header = T, sep= ";")
por <- read.csv()

url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"

# web address for math class data
url_math <- paste(url, "student-mat.csv", sep = "/")

# print out the address
url_math

# read the math class questionaire data into memory
math <- read.table(url_math, sep = ";" , header=TRUE)

# web address for portuguese class data
url_por <- paste(url, "student-por.csv", sep ="/ ")
url_por
# read the portuguese class questionaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)
View (por)
# look at the column names of both data
colnames(math)


#explore the structure and dimensions of the data

# alc is available

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
dim(alc)
# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes (x=high_use), col=sex)

# draw a bar plot of high_use by sex
g2 + geom_bar(aes (x= sex, y= high_use))

gather(alc) %>% glimpse
# draw a bar plot of each variable
gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free")