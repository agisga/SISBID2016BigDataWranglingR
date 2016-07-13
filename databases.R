library(babynames)

#--------------------------------
# dplyr
#--------------------------------
library(dplyr)
library(pryr)

?babynames
#View(babynames)
str(babynames)
object_size(babynames)

# Getting set up
my_db <- src_sqlite("my_db.sqlite3", create = T)
babys_sqlite <- copy_to(my_db, babynames, temporary = FALSE)
src_tbls(my_db)
tbl(my_db,"babynames")

# Now you can use dplyr just like before
newtbl = my_db %>%
  tbl("babynames")%>%
  filter(name=="Hilary") %>%
  select(year,n,name)
newtbl
# only the first 10 rows

newtbl = my_db %>%
  tbl("babynames")%>%
  filter(name=="Hilary") %>%
  select(year,n,name)
output = newtbl %>% collect()
# collect() asks for the whole result

popular = babynames %>%
  group_by(name) %>%
  summarise(N = sum(n)) %>%
  arrange(desc(N)) %>% top_n(100)
popular

popular = my_db %>%
  tbl('babynames')%>%
  group_by(name) %>%
  summarise(N = sum(n)) %>%
  arrange(desc(N)) %>% top_n(100)
popular
# top_n not supported by the database for this data frame

# this works:
popular = my_db %>%
  tbl('babynames')%>%
  group_by(name) %>%
  summarise(N = sum(n)) %>%
  arrange(desc(N)) %>% collect() %>%
  top_n(100)
popular

# how female:
how_female = my_db %>%
  tbl("babynames") %>%
  group_by(name) %>%
  summarize(m=mean(sex=="F"))
explain(how_female)
head(how_female)

#-----------------------------------------
# data.table
#-----------------------------------------

library(data.table)
library(readr)

# compare data read in times:
write_csv(babynames, 'babynames.csv')
system.time(read.csv('babynames.csv')) # base
#  user  system elapsed
# 6.796   0.040   6.837
system.time(read_csv('babynames.csv')) # readr
#  user  system elapsed
# 1.396   0.020   1.517
system.time(fread('babynames.csv')) # data.table
#  user  system elapsed
# 1.008   0.000   1.010

baby_dt = fread('babynames.csv')
class(baby_dt)
female = baby_dt[sex=="F"]
dim(female)
baby_dt[sex=="F", .(n,name,prop)] # `.()` means function applied to variables; this argument can be any R function
baby_dt[sex=="F", .(name,mean(prop))]
baby_dt[sex=="F", .(name,mean(prop)), name] # group by name
baby_dt[sex=="F", .(name,aveprop=mean(prop)), name] # specify new variable name
# speed and memory efficient way to define new column:
baby_dt[,aveprop:=mean(prop),name]
