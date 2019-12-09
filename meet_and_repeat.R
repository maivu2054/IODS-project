#Mai Vu 9 Dec 19

rm(list = ls())
library (dplyr)
library (tidyverse)
library (ggplot2)
library(tidyr)

#read data sets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#discover data sets
names(BPRS)
str(BPRS)
summary (BPRS)

names(RATS)
str(RATS)
glimpse (RATS)
summary (RATS)
#See how data look like

View (BPRS)

View (RATS)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form (note:The gather() function takes multiple columns and collapses them into key-value pairs, so that we can have the weeks as values of a new variable week)
# Extract the week number by substr and creat new var (week) BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)%>% mutate(week = as.integer(substr(weeks, 5, 5)))
view (BPRSL)
write.csv(BPRSL, file = "bprs.csv")

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% 
  mutate(Time = as.integer(substr(WD,3,4))) 
view (RATSL)
write.csv(RATSL, file = "rats.csv")

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

glimpse(RATSL)










