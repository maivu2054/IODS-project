
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
colnames(gii)[4] <- "raternity_mort"
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
