circ = read.csv("Charm_City_Circulator_Ridership.csv", as.is = TRUE)
head(circ, 2)

library(lubridate) # great for dates!
library(dplyr) # mutate/summarise functions

circ = mutate(circ, date = mdy(date))
sum(is.na(circ$date) ) # all converted correctly
head(circ$date)

library(stringr)
cn = colnames(circ)
cn = cn %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 
colnames(circ) = cn
cn

#--- Reshaping data from wide (fat) to long (tall): tidyr
library(tidyr)
long = gather(circ, key = "var", value = "number", 
              starts_with("orange"),
              starts_with("purple"), 
              starts_with("green"),
              starts_with("banner"))
head(long)
head(circ)
table(long$var)

# separate by line (orange, etc.) and type (Boardings, etc.)
long = separate_(long, "var", 
                 into = c("line", "type"), 
                 sep = "[.]")
head(long)
unique(long$line)
unique(long$type)

# finding first or last record
long = long %>% filter(!is.na(number) & number > 0)
first_and_last = long %>% arrange(date) %>% # arrange by date
  filter(type %in% "Boardings") %>% # keep boardings only
  group_by(line) %>% # group by line
  slice( c(1, n())) # select ("slice") first and last (n() command) lines
first_and_last

#--- Reshaping data from long (tall) to wide (fat): tidyr
# have to remove missing days
wide = filter(long, !is.na(date))
wide = spread(wide, type, number)
head(wide)

# find rows which have no missing values in Alightings, Average, Boardings
namat = !is.na(select(wide, Alightings, Average, Boardings))
head(namat)
wide$good = rowSums(namat) > 0
head(wide)

# take the good subset
wide = filter(wide, good) %>% select(-good)
head(wide)
