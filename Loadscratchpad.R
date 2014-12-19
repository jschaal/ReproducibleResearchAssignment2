#Helper functions

d2011 <- 9.33
d1950 <- 1.00
yrs <- 2011-1950
inflation <- (d2011/d1950)^(1/yrs) - 1
inflation

df <- function (e,eyear,inf) {
  if (is.null(e) || is.na(e))  f <-1 
  else if (e %in% c("K","k")) f <- 1e3 
  else if (e %in% c("M","m")) f <- 1e6
  else if (e %in% c("B","b")) f <- 1e9
  else f <- 1
  f * (1+inf)^(2011-eyear)
}

dfv <- Vectorize(df)
# Process Data

data <- read.csv("./data/repdata_data_StormData.csv.bz2",as.is=TRUE)
save(data,file="./data/data.RData")


library(dplyr)
library(lubridate)
dataSubset <- tbl_df(data)
dataSubset <- select(dataSubset,REFNUM,EVTYPE,BGN_DATE,FATALITIES,INJURIES,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP)
dataSubset$year <- year(mdy_hms(dataSubset$BGN_DATE))
dataSubset$damage <- 
  (dataSubset$PROPDMG * dfv(dataSubset$PROPDMGEXP,dataSubset$year,inflation)) +
  + (dataSubset$CROPDMG * dfv(dataSubset$CROPDMGEXP,dataSubset$year,inflation))
dataSubset$casualties <- dataSubset$FATALITIES + dataSubset$INJURIES
save(dataSubset,file="./data/dataSubset.RData")



