

#data = read.csv('data/US_Accidents_Dec19.csv', stringsAsFactors = F)
#save(data, file = 'data.Rdata')

load('input/data.Rdata')

library(dplyr)
library(ggplot2)
options(scipen = 999) #disable scientific notation

data$Start_Time = as.character(data$Start_Time)
x = data$Start_Time[1]

accidents_all = data %>% 
  mutate(Year = as.numeric(substr(Start_Time,1,4))) %>% # this is to get just the substring of the year, the first four characters
  group_by(State, Year) %>% 
  summarise(n = n()) %>% 
  rename('Number of Accidents' = n) # renaming the count 'n' as ' Number of Accidents'
  
save(accidents_all,file = 'data/accidents_all.Rdata')


severity = data %>% 
  mutate(Year = as.numeric(substr(Start_Time,1,4))) %>% 
  filter(Year != 2015, Year !=2020) %>% 
  group_by(Year, Severity) %>% 
  count() %>% 
  rename('Accidents' = n) %>% # renaming the count 'n' as 'Accidents'
  ungroup()

save(severity, file = 'input/severity.Rdata')

severity$Year = factor(severity$Year)
severity$Severity = factor(severity$Severity)

ggplot(data=severity, aes(x=Year, y=NAC, fill=Severity)) +
  geom_bar(stat='identity', position=position_dodge()) +
  scale_y_continuous(trans='log10')
  

data_sample = data.frame(lapply(data[1:1000,], as.character), stringsAsFactors=FALSE) # I am only displaying 1000 rows
save(data_sample,file = 'data_sample.Rdata')



