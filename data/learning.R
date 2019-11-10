#Mai Vu 10 Nov 19 
#install some packages:
installed.packages(c("dplyr", "openxlsx","readxl", "ggplot2"))
#data description
# read data
# read the data into memory, separator is a tab ("\t") including header 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
View (lrn14)
head (lrn14)
# Look at the dimensions of the data
dim (lrn14)
# Look at the structure of the data
str (lrn14) 
# print the "Attitude" column vector fo the lrn14 data
lrn14$Attitude
# create column 'attitude' by scaling the column "Attitue"
lrn14$attitude <- lrn14$Attitude/10
library (dplyr)
#creat 3 variables: deep_questions, surface_questions, strategic_questions from lrn14 dataset
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#creat 3 variables deep, surf, stra by select and mean of above variables. E.g: 
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select (lrn14, one_of (strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#creat keep_columns including: "gender","Age","attitude", "deep", "stra", "surf", "Points"
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
#creat data set learning2014 by select variable from keep_columns
learning2014 <-  select (lrn14, one_of(keep_columns))
head(learning2014)
dim(learning2014)
View (learning2014)
colnames(learning2014)
colnames(learning2014)[7] <- "points"
colnames(learning2014)[2] <- "age"
learning2014 <- filter (learning2014, points>0)
dim(learning2014)

# Change working directory to IODS-folder
setwd("~/IODS-project")

# Save created data to folder 'data' as an Excel worksheet
# install.packages("openxlsx")
library(openxlsx)
write.xlsx(learning2014,file="~/IODS-project/data/learning2014.xlsx")
#plot
library(ggplot2)



#
#
#install.
#plot 

hist (lrn4$Points)
plot (Attitute anad Assenne)
#creat column by scaling 
#cread deep
#exclude observation
#select var, mutate ()
setwd ("~/ IOS")...
library (openxlsx)
library (readxl)
#read data
#change var.
str(learning2014, chuyen var sang factor)
head ()








