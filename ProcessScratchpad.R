#Process 
library(dplyr)
load("./data/dataSubset.RData")

rd2 <- dataSubset %>% 
  group_by(year,EVTYPE) %>%
  summarize(damage=sum(PROPDMG+CROPDMG),casualties=sum(FATALITIES+INJURIES))

# Damage
rd3 <- rd2 %>%
  group_by(EVTYPE) %>%
  summarize(damage=sum(damage)) %>%
  arrange(desc(damage))

t <- sum(rd3$damage)
rd3$pct <- rd3$damage/t
rd3$cpct <- cumsum(rd3$pct)
rd4 <- filter(rd3,cpct<=.95)
barplot(rd4$damage,names.arg = rd4$EVTYPE)

