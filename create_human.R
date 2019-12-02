dev.off()
break()
rm(list = ls())

library(ggplot2)
library(dplyr)
#2) Reading the Human  development and Gender inequality datas into R.
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
#3) Explore the datasets:
View(hd)
View (gii)
str(hd)
str(gii)
summary(hd)
summary(gii)

#4) Renaming the variables with (shorter) descriptive names.
#hd data
colnames(hd)[3] <- "HDI" 
colnames(hd)[4] <- "life_expect"
colnames(hd)[5] <- "y_of_edu"
colnames(hd)[6] <- "mean_edu"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI_rank"

#see column after rename the variables with (shorter) descriptive names
colnames(hd)

#gii data
colnames(gii)[3] <- "GII_index"
colnames(gii)[4] <- "mater_mort"
colnames(gii)[5] <- "birthrate"
colnames(gii)[6] <- "repinparliament"
colnames(gii)[7] <- "edu_F"
colnames(gii)[8] <- "edu_M"
colnames(gii)[9] <- "female_labour"
colnames(gii)[10] <- "male_labour"
summary(gii)

# 5) Mutating the variables 

gii <- mutate(gii, edu_ratio = (edu_F/edu_M))
gii <- mutate(gii, participation_ratio = (female_labour/male_labour))

# 6) Joining the datasets by "Country"-column

join_by <- c("Country")

human <- inner_join(gii, hd, by = join_by, suffix = c(".gii", ".hd"))

glimpse(human)
head (human)

write.table(human, file= "human.csv")
##################

# Date 1 Dec 2019: Excercise 5

# Q1: change GNI to numeric and data description
install.packages("stringr")
library(stringr)
library(MASS)
library(stringr)
library (tidyr)
library (dplyr)

#structure of human and GNI
str(human)
str (human$GNI)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()
human$GNI%>%as.numeric(str_replace(human$GNI, pattern=",", replace =""))
head(human[, 1:19], 4)

# Q2 
"Excluding unneeded variables keep only the columns matching the following variable names: 
Country, Edu2.FM, Labo.FM, Edu.Exp, Life.Exp, GNI, Mat.Mor, Ado.Birth, Parli.F"

keep <- c("Country", "edu_ratio", "participation_ratio", "life_expect",
          "y_of_edu", "GNI", "mater_mort", "birthrate", "repinparliament")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))


# 3 Dealing with not available (NA) values
# print out a completeness indicator of the logical "completeness indicator" vector
complete.cases(human)
# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))
head (human_)
str(human_)

# 4 Removing observations relating to regions instead of countries
# define the last indice we want to keep
last <- nrow(human_) - 7
# choose everything until the last 7 observations
human_ <- human_[1:last,]

# Defining the row names and removing country columns

rownames(human_) <- human_$Country

human_ <- dplyr::select(human_, -Country)

str(human_)
# The data should now have 155 observations and 8 variables
write.table(human_, file= "human_.csv")
