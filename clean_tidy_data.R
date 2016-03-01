library(lubridate)
library(dplyr)
#macronutriment information coming from MyFitnessPal
mfp<-read.csv("./data/MyFitnessPal_data.csv") 
# Sleep quality information coming from Sleep Cycle iOS version
sleep <- read.csv("./data/sleepdata.csv", sep=";")
# Resting Heart Rate coming from Withing Scale measurement
hr <- read.csv("./data/hrdata.csv", header=TRUE,sep=",", quote = "")

#Cleaning and preparing MyFitnessPal file (only keeping Carb, Fat and Protein reaading)
mfp$date<-mdy(as.character(mfp$date))
Fit_data <- mfp %>% select(date,Carbs.Consumed,Fat.Consumed,Protein.Consumed)
Fit_data <- tbl_df(Fit_data)

#Cleaning and preparing Sleep Cycle file (only keeping the quality measure)
sleep <- sleep %>% mutate(date = Start)
sleep$date <- ymd(as.Date(sleep$date))
sleep$Sleep.quality <- gsub('%', '', sleep$Sleep.quality)
sleep$Sleep.quality <- as.numeric(sleep$Sleep.quality)
sleep_data <- sleep %>% select(date,Sleep.quality)
sleep_data <- tbl_df(sleep_data)

#Cleaning Withing file to keep only Resting Heart rate information
names(hr)[2] <- "Heart.rate" #replace by setnames()
names(hr)[1] <- "date" #replace by setnames()
hr$date <- ymd(as.Date(hr$date))
hr_data <- hr %>% select(date,Heart.rate)

#Merging all files where ALL information are available for prototyping purpose
combine_data <- merge(Fit_data,sleep_data, by="date")
combine_data <- merge(combine_data,hr_data, by="date")

#Ensuring all variable have the right format
combine_data$Carbs.Consumed <- as.numeric(combine_data$Carbs.Consumed)
combine_data$Fat.Consumed <- as.numeric(combine_data$Fat.Consumed)
combine_data$Protein.Consumed <- as.numeric(combine_data$Protein.Consumed)
combine_data$Heart.rate <- as.numeric(combine_data$Heart.rate)

#Writing final file
write.csv(combine_data,"./data/MyFitness_data.csv", row.names=FALSE)
