install.packages("rfigshare")
library(rfigshare)

# Need a figshare account for this...
# Maybe also need to be J. Leek for this....
leeksearch = fs_search("Leek")
length(leeksearch)
leeksearch[[1]]

#--------------------------------------------------------

install.packages("httr")
library(httr)

query.url = "https://api.github.com/search/repositories?q=created:2016-07-12+language:r+-user:cran"
req = GET(query.url)
content(req)
names(content(req))
content(req)["total_count"]

#-------------------------------------------------------
# APIs lab (https://github.com/SISBID/Module1/blob/gh-pages/labs/web-api-lab.Rmd)
#-------------------------------------------------------

# (1)
library(jsonlite)
oct4_dat = fromJSON("http://rest.ensembl.org//lookup/id/ENSG00000204531?content-type=application/json;expand=1")
class(oct4_dat)
names(oct4_dat)
class(oct4_dat$Transcript)
str(oct4_dat$Transcript)
dim(oct4_dat$Transcript)
names(oct4_dat$Transcript)
oct4_dat$Transcript[ , c("Parent", "id", "species", "start", "end")]

# (2)
P53 = fromJSON("http://rest.ensembl.org//lookup/id/ENSG00000141510?content-type=application/json;expand=1")
dim(P53$Transcript)
names(P53$Transcript)
P53$Transcript[ , c("Parent", "id", "species", "start", "end")]
