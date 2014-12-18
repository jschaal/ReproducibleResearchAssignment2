# Process Data
data <- read.csv("./data/repdata_data_StormData.csv.bz2",as.is=TRUE)
save(data,file="./data/data.RData")
library(dplyr)
library(lubridate)
dataSubset <- tbl_df(data)
dataSubset <- select(dataSubset,REFNUM,EVTYPE,BGN_DATE,FATALITIES,INJURIES,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP)
dataSubset$year <- year(mdy_hms(dataSubset$BGN_DATE))
save(dataSubset,file="./data/dataSubset.RData")
