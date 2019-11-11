#Mai Vu 10 Nov 19 
#install some packages:
install.packages(c("dplyr", "xlsx", "ggplot2", "GGally"))
library (dplyr)
library (xlsx)
library(ggplot2)
library(GGally)
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
#setwd("~/IODS-project")
setwd(getwd())
# Save created data to folder 'data' as an Excel worksheet
# install.packages("openxlsx")
library("xlsx")
write.xlsx(learning2014,file="learning2014.xlsx", header=T)
read.xlsx ("learning2014.xlsx")
View (learning2014)
# Or reading data from website
learning2014 <- read.table ("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
#plot
library(ggplot2)
p1 <- ggplot(learning2014, aes(x = attitude, y = points))
p2 <- p1 + geom_point()
p3 <- p2 + geom_smooth(method = "lm")
p4 <- p3 + ggtitle ("Correlation between attitude and points")
print (p4)
pairs.panels (learning2014)
library(GGally)
p <- ggpairs(learning2014, mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))

p1 <- ggpairs(learning2014, 
        mapping = aes(col = gender, alpha = 0.3), 
        lower = list(combo = wrap("facethist", bins = 20))
)