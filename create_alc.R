#Mai Vu 13 Nov 19
#read both student-mat.csv and student-por.csv into R 
#First install.packages(c("dplyr"), ("ggplo2"))

#Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data
url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"

url_math <- paste(url, "student-mat.csv", sep = "/")

math <- read.table(url_math, sep = ";" , header=TRUE)

url_por <- paste(url, "student-por.csv", sep = "/")

por <- read.table(url_por, sep = ";", header = TRUE)

str(por)

str(math)

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)
#Join the two data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers. Keep only the students present in both data sets

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

glimpse(math_por)

str(math_por)
"The new dataset has 382 observations and 53 variables"

#Removing duplicates

dat <- select(math_por, one_of(join_by))


notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  
  two_columns <- select(math_por, starts_with(column_name))  
  
  first_column <- select(two_columns, 1)[[1]]
  
  
  if(is.numeric(first_column)) { dat[column_name] <- round(rowMeans(two_columns))} else { dat[column_name] <- first_column }}

glimpse(dat)  

"With the duplicates removed the data now has 382 observations and 33 variables"

#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data.

library(ggplot2)

dat <- mutate(dat, alc_use = (Dalc + Walc) / 2)

dat <- mutate(dat, high_use = alc_use > 2)

glimpse(dat)

#Save the joined and modified data set to the 'data' folder, using for example write.csv() or write.table() functions

write.table(dat, file= "alc_use.csv")

