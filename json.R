install.packages("jsonlite")
library(jsonlite)
library(dplyr)

github_url = "https://api.github.com/users/agisga/repos"
jsonData <- fromJSON(github_url)
jsonData
dim(jsonData)
jsonData$name

sapply(jsonData, class) 
sapply(jsonData, class) %>% table

dim(jsonData$owner)
head(jsonData$owner)
names(jsonData$owner)
jsonData$owner$html_url
